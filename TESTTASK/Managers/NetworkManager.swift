//
//  NetworkManager.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func fetchUsers(page: Int, completion: @escaping (UserResponse?) -> Void)
    func registerUser(user: LocalUserModel, completion: @escaping (UserStatusResponse) -> Void)
    func getToken(completion: @escaping (String) -> Void)
}

private struct TokenResponse: Decodable {
    let success: Bool
    let token: String
}

final class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager: NetworkManagerProtocol {
    
    func fetchUsers(page: Int, completion: @escaping (UserResponse?) -> Void) {
        let url = "https://frontend-test-assignment-api.abz.agency/api/v1/users"
        let parameters: Parameters = ["page": page, "count": 6]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                    case .success(let users):
                        completion(users)
                    case .failure(let error):
                        print("Error fetching users: \(error.localizedDescription)")
                        completion(nil)
                }
            }
    }
    
    func registerUser(user: LocalUserModel, completion: @escaping (UserStatusResponse) -> Void) {
        getToken { token in
            let url = "https://frontend-test-assignment-api.abz.agency/api/v1/users"
            let headers: HTTPHeaders = [
                "Token": token
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(Data(user.name.utf8), withName: "name")
                multipartFormData.append(Data(user.email.utf8), withName: "email")
                multipartFormData.append(Data(user.phone.utf8), withName: "phone")
                multipartFormData.append(Data("\(user.positionID)".utf8), withName: "position_id")
                multipartFormData.append(user.photo, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
            }, to: url, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                    case .success(let value):
                        print("Registration success: \(String(data: value!, encoding: .utf8) ?? "No response body")")
                        completion(.success)
                        
                    case .failure(let error):
                        if let responseCode = response.response?.statusCode, responseCode == 409 {
                            completion(.duplicatedEmailOrPhone)
                        } else if let responseCode = response.response?.statusCode, responseCode == 422 {
                            completion(.invalidEmailOrPhone)
                        } else {
                            completion(.unknownError)
                        }
                        
                        if let data = response.data,
                           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let message = json["message"] as? String,
                           let fails = json["fails"] as? [String: Any] {
                            print("Registration failed: \(message)")
                            print("Details: \(fails)")
                        } else {
                            print("Registration failed: \(error.localizedDescription)")
                        }
                }
            }
        }
    }
    
    func getToken(completion: @escaping (String) -> Void) {
        let url = "https://frontend-test-assignment-api.abz.agency/api/v1/token"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                    case .success(let tokenResponse):
                        completion(tokenResponse.token)
                    case .failure(let error):
                        print("Token fetch failed: \(error)")
                        completion("")
                }
            }
    }
}

enum UserStatusResponse {
    case invalidEmailOrPhone
    case success
    case unknownError
    case duplicatedEmailOrPhone
}
