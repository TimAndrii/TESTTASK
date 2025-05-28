//
//  InfoScreenView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct InfoScreenView: View {
    let imageName: String
    let title: String
    let buttonTitle: String
    let showXButton: Bool
    let showMainButton: Bool
    let buttonAction: (() -> Void)
    let buttonXAction: (() -> Void)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 40)

                Spacer()

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 24)

                Text(title)
                    .font(.NSMedium18)
                    .multilineTextAlignment(.center)

                if showMainButton {
                    Button(action: buttonAction) {
                        Text(buttonTitle)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 140, height: 48)
                            .background(Color.YellowAppColor)
                            .cornerRadius(24)
                    }
                    .padding(.top, 24)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.white)

            if showXButton {
                Button(action: buttonXAction) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .frame(width: 24, height: 24)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    InfoScreenView(imageName: "unsuccess", title: "That email is already registered", buttonTitle: "Try again", showXButton: true, showMainButton: true) {
        print("DD")
    } buttonXAction: {
        print("XX")
    }
}
