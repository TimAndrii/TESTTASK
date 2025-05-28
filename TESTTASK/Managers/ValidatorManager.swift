//
//  ValidatorManager.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import Foundation
import UIKit

struct ValidationManager {

    static func validateEmail(_ email: String, focused: Bool) -> (Bool, String) {
        guard focused else { return (true, "") }

        if email.isEmpty {
            return (false, FieldErrorType.requiredField.rawValue)
        }

        if email.count < 6 || email.count > 100 {
            return (false, "Email must be between 6 and 100 characters")
        }

        let pattern = #"^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"# +
        #""(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]"# +
        #"|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@"# +
        #"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"# +
        #"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$"#

        let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(location: 0, length: email.utf16.count)
        let isValid = regex?.firstMatch(in: email, options: [], range: range) != nil

        return (isValid, isValid ? "" : FieldErrorType.invalidEmail.rawValue)
    }

    static func validateName(_ name: String, focused: Bool) -> (Bool, String) {
        let isValid = name.count >= 3
        return focused ? (isValid, isValid ? "" : FieldErrorType.requiredField.rawValue) : (true, "")
    }

    static func validatePhone(_ phone: String, focused: Bool) -> (Bool, String) {
        guard focused else { return (true, "+38 (XXX) XXX - XX - XX") }

        if phone.isEmpty {
            return (false, FieldErrorType.requiredField.rawValue)
        }

        let pattern = #"^[\+]{0,1}380([0-9]{9})$"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: phone.utf16.count)
        let isValid = regex?.firstMatch(in: phone, options: [], range: range) != nil

        return (isValid, isValid ? "" : "+38 (XXX) XXX - XX - XX")
    }

    static func validatePhoto(_ image: Data?, focused: Bool) -> (Bool, String) {
        let isValid = image != nil
        return focused ? (isValid, isValid ? "" : FieldErrorType.requiredPhoto.rawValue) : (true, "")
    }
    
}
