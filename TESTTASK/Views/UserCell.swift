//
//  UserCell.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct UserCell: View {
    let user: User

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: user.photo)) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 70, height: 70)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.NSSemiBold)
                    .lineLimit(2)

                Text(user.position)
                    .font(.NSSemiLight14)

                Text(user.email)
                    .font(.NSMedium14)
                    .lineLimit(1)

                Text(user.phone)
                    .font(.NSMedium14)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
