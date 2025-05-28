//
//  CustomFieldView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct CustomField: View {

    @FocusState private var isFocused: Bool
    @Binding var textField: String
    let prompt: String
    var isValidate: Bool
    let infoText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isValidate ? Color.gray : Color.red, lineWidth: 1)
                    .frame(height: 56)

                ZStack(alignment: .leading) {
                    // Floating label
                    Text(prompt)
                        .foregroundColor(isValidate ? .gray : .red)
                        .font(isFocused || !textField.isEmpty ? .NSSemiLight14 : .body)
                        .scaleEffect(isFocused || !textField.isEmpty ? 0.96 : 1.0, anchor: .leading)
                        .offset(y: isFocused || !textField.isEmpty ? -15 : 0)
                        .padding(.leading, 12)
                        .animation(.easeInOut(duration: 0.2), value: isFocused || !textField.isEmpty)
                        .foregroundStyle(isValidate ? .gray : .red)

                    // Input field
                    TextField("", text: $textField)
                        .focused($isFocused)
                        .padding(.leading, 12)
                        .padding(.top, 15)
                        .frame(height: 56)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
                .padding(.horizontal, 4)
            }
            .padding(.horizontal)

            // Error/info message
            Text(infoText)
                .font(.NSSemiLight14)
                .foregroundColor(isValidate ? .gray : .red)
                .padding(.leading, 32)
                .animation(.easeInOut(duration: 0.2), value: infoText)

        }
    }
}
