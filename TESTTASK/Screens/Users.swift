//
//  Users.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct UsersScreen: View {
    @State private var haveInternetConnection: Bool = false
    
    @State private var users: [User] = []
    @State private var isLoading = false
    @State private var currentPage = 0
    @State private var totalPages = 1

    var body: some View {
        VStack {
            BannerView(title: "Working with GET request")

            if haveInternetConnection {
                InfoScreenView(imageName: "success-image",
                               title: "There are no users yet",
                               buttonTitle: "",
                               showXButton: false,
                               showMainButton: false) {} buttonXAction: {}
            } else {
                VStack {
                    List {
                        ForEach(users, id: \.self) { user in
                            UserCell(user: user)
                        }

                        if currentPage < totalPages {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.8)
                                    .onAppear {
                                        loadMoreUsersIfNeeded()
                                    }
                                Spacer()
                            }

                        }
                    }
                    .listStyle(.plain)
                    .padding(.horizontal, 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onChange(of: users) { _, newValue in
            users = newValue.sorted { $0.registrationTimestamp > $1.registrationTimestamp }
        }
    }

    @MainActor
    private func loadUsers(page: Int) {
        guard !isLoading, page <= totalPages else { return }
        isLoading = true
        
        NetworkManager.shared.fetchUsers(page: page) { response in
            if let responseUser = response {
                users.append(contentsOf: responseUser.users)
                totalPages += 1
                currentPage = responseUser.page
            }
            isLoading = false
        }
    }

    private func loadMoreUsersIfNeeded() {
        loadUsers(page: currentPage + 1)
    }
}

