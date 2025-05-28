//
//  RadioButtonView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct RadioButton: View {
    let label: Positions
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(Color.CayanAppColor, lineWidth: 1)
                    .frame(width: 14, height: 14)

                if isSelected {
                    Circle()
                        .fill(Color.CayanAppColor)
                        .frame(width: 14, height: 14)

                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                }
            }

            Text(label.title)
                .foregroundColor(.black)
                .font(.NSMedium16)

            Spacer()
        }
        .frame(height: 48)
        .padding(.leading, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        .padding(.horizontal)
    }
}
