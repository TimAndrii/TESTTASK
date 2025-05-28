//
//  User.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import Foundation
import UIKit

struct UserResponse: Codable {
    let page: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case page
        case users
    }
}

// MARK: - User
struct User: Codable, Hashable {
    let id: Int
    let name, email, phone, position: String
    let positionID, registrationTimestamp: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionID = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}

struct LocalUserModel {
    var name: String
    var email: String
    var photo: Data
    var phone: String
    var positionID: Int
}
