//
//  SplashScreen.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//
import SwiftUI

struct SplashScreen: View {

    @State private var isActive = false

    var body: some View {
        if isActive {
            ContainerScreen()
        } else {
            ZStack {
                Rectangle()
                    .fill(Color.YellowAppColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            .overlay {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 106)

            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }

}

#Preview {
    SplashScreen()
}
