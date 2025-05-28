//
//  SignUp.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct SignUp: View {

    @Binding var tabSelection: TabState
    @Binding var hideTab: Bool

    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var name:  String = ""
    @State private var position: Positions = .front
    @State private var image: Data? = nil

    @State private var isPickerPresented = false
    @State private var isSourceDialogShown = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @State private var focusedFields: [FieldType: Bool] = [:]
    @State private var infoStatusView: UserStatusResponse? = nil

    @FocusState private var focusedField: FieldType?

    private var emailValidation: (Bool, String) {
        ValidationManager.validateEmail(email, focused: focusedFields[.email] ?? false)
    }

    private var nameValidation: (Bool, String) {
        ValidationManager.validateName(name, focused: focusedFields[.name] ?? false)
    }

    private var phoneValidation: (Bool, String) {
        ValidationManager.validatePhone(phone, focused: focusedFields[.phone] ?? false)
    }

    private var photoValidation: (Bool, String) {
        ValidationManager.validatePhoto(image, focused: focusedFields[.photo] ?? false)
    }

    var body: some View {
        VStack {
            BannerView(title: "Working with POST request")

            ScrollView {
                formContent()
            }
        }
        .overlay {
            Group {
                if infoStatusView != nil {
                    InfoScreenView(
                        imageName: "success",
                        title: "User successfully registered",
                        buttonTitle: "Got It",
                        showXButton: true,
                        showMainButton: true,
                        buttonAction: {
                            if infoStatusView == .success {
                                infoStatusView = nil
                                tabSelection = .users
                                hideTab = false
                            } else if infoStatusView == .duplicatedEmailOrPhone {
                                infoStatusView = nil
                                hideTab = false
                            }

                        },
                        buttonXAction: {
                            if infoStatusView == .success {
                                infoStatusView = nil
                                tabSelection = .users
                                hideTab = false
                            } else if infoStatusView == .duplicatedEmailOrPhone {
                                infoStatusView = nil
                                hideTab = false
                            }

                        }
                    )
                }
            }
            .animation(.spring, value: infoStatusView)
        }
        .onChange(of: infoStatusView) { _, newValue in
            if case .success = newValue {
                hideTab = true
            }
        }

    }

    private func bindingFieldType(for field: FieldType) -> Binding<String>? {
        switch field {
            case .name: return $name
            case .email: return $email
            case .phone: return $phone
            case .photo: return nil
            case .position: return nil
        }
    }

    private func validateFields(fieldType: FieldType) -> (Bool, String) {
        switch fieldType {
            case .email:
                return emailValidation
            case .name:
                return nameValidation
            case .phone:
                return phoneValidation
            case .photo:
                return photoValidation
            case .position:
                return (true, "")
        }
    }

    private func validateAllData() -> Bool {
        FieldType.allCases.allSatisfy { field in
            validateFields(fieldType: field).0
        }
    }

    private func formContent() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack {
                ForEach(FieldType.allCases, id: \.self) { field in
                    if field != .photo {
                        if let binding = bindingFieldType(for: field) {
                            CustomField(
                                textField: binding,
                                prompt: field.prompt,
                                isValidate: validateFields(fieldType: field).0,
                                infoText: validateFields(fieldType: field).1
                            )
                            .focused($focusedField, equals: field)
                            .onChange(of: focusedField) { oldValue, newValue in
                                if let old = oldValue, old == field {
                                    focusedFields[old] = true
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 32)

            PositionsView(position: $position)

            PhotoFieldView(isSourceDialogShown: $isSourceDialogShown,
                           isPickerPresented: $isPickerPresented,
                           image: $image,
                           sourceType: $sourceType,
                           photoValidation: photoValidation.0)

            HStack {
                Spacer()
                Button(action: {
                    if validateAllData() {
                        if image != nil {
                            let user = LocalUserModel(
                                name: name,
                                email: email.lowercased(),
                                photo: image!,
                                phone: phone,
                                positionID: position.id
                            )
                            NetworkManager.shared.registerUser(user: user) { status in
                                infoStatusView = status
                            }
                        } else {
                            focusedFields[.photo] = true
                        }
                    } else {
                        focusedFields = FieldType.allCases.reduce(into: [FieldType: Bool]()) { result, field in
                            result[field] = true
                        }
                    }
                }) {
                    Text("Sign up")
                        .foregroundStyle(.black)
                        .frame(width: 140, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.YellowAppColor)
                        )
                }
                Spacer()
            }

            Spacer()
        }
    }
}

#Preview {
    SignUp(tabSelection: .constant(.signUp), hideTab: .constant(true))
}
