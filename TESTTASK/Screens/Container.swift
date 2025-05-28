//
//  Container.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct ContainerScreen: View {

    @State private var tabState: TabState = .users
    @State private var hideTab: Bool = false
    @State private var isConnected: Bool = true
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                switch tabState {
                    case .users:
                        UsersScreen()
                    case .signUp:
                        SignUp(tabSelection: $tabState, hideTab: $hideTab)
                }
            }
            .padding(.bottom, hideTab ? 0 : 56)

            if !hideTab {
                TabView(state: $tabState)
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .ignoresSafeArea(edges: .bottom)
            }

            if !isConnected {
                InfoScreenView(
                    imageName: "lostInternet",
                    title: "There is no internet connection",
                    buttonTitle: "Try again",
                    showXButton: false,
                    showMainButton: true,
                    buttonAction: {
                        checkConnection()
                    },
                    buttonXAction: {}
                )
            }
        }
        .onAppear {
            checkConnection()
        }
        .onReceive(timer) { _ in
            checkConnection()
        }
        .ignoresSafeArea(.keyboard)
    }

    private func checkConnection() {
        NetworkManager.shared.getToken() { str in
            isConnected = str != ""
        }
    }
}

#Preview {
    ContainerScreen()
}
