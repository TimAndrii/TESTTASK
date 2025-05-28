//
//  CustomPhotoField.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct CustomPhotoField: View {

    @Binding var isSourcePresented: Bool
    @Binding var isPickerPresented: Bool
    @Binding var selectedImage: Data?

    var sourceType: UIImagePickerController.SourceType

    let isValidate: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                isSourcePresented = true
            } label: {
                HStack {
                    Text(selectedImage == nil ? "Upload your photo" : "Photo selected")
                        .foregroundColor(isValidate ? .black : .red)
                    Spacer()
                    Text("Upload")
                        .font(.NSMedium16)
                        .foregroundStyle(Color.CayanAppColor)
                }
                .padding()
                .frame(height: 56)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isValidate ? Color.gray : Color.red, lineWidth: 1)
                )
                .padding(.horizontal)
            }
            
            if !isValidate {
                Text(FieldErrorType.requiredPhoto.rawValue)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.leading, 32)
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(image: $selectedImage, sourceType: sourceType)
        }

        .padding(.top, 24)
    }
}
