//
//  TabView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct TabView: View {

    @Binding var state: TabState

    var body: some View {
        HStack {
            Spacer()

            Button {
                state = .users
            } label: {
                Image("Symbol-2")
                Text("Users")
            }
            .foregroundStyle(state == .users ? Color.CayanAppColor : .black)

            Spacer()

            Button {
                state = .signUp
            } label: {
                Image("Symbol-3")
                Text("Sign up")
                    .font(.NSMedium16)
            }
            .foregroundStyle(state == .signUp ? Color.CayanAppColor : .black)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color.init(hex: "#F8F8F8"))
    }
}

enum TabState {
    case users
    case signUp
}
