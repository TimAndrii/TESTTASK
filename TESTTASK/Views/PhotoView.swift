//
//  PhotoView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 28.05.2025.
//

import SwiftUI

struct PhotoFieldView: View {

    @Binding var isSourceDialogShown: Bool
    @Binding var isPickerPresented: Bool
    @Binding var image: Data?
    @Binding var sourceType: UIImagePickerController.SourceType
    var photoValidation: Bool

    var body: some View {
        VStack {
            CustomPhotoField(
                isSourcePresented: $isSourceDialogShown,
                isPickerPresented: $isPickerPresented,
                selectedImage: $image,
                sourceType: sourceType,
                isValidate: photoValidation
            )
            .padding(.bottom, 24)
            .confirmationDialog("Select Image Source", isPresented: $isSourceDialogShown, titleVisibility: .visible) {
                Button("Take Photo") {
                    sourceType = .camera
                    isPickerPresented = true
                }

                Button("Choose from Gallery") {
                    sourceType = .photoLibrary
                    isPickerPresented = true
                }

                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
