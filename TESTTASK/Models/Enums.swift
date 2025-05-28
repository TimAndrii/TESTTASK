//
//  Enums.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import Foundation

enum FieldErrorType: String {
    case requiredField = "Required field"
    case invalidEmail  = "Invalid email format"
    case requiredPhoto = "Photo is required"
}

enum FieldType: CaseIterable {
    case name
    case email
    case phone
    case position
    case photo

    var prompt: String {
        switch self {
            case .name: return "Your name"
            case .email: return "Email"
            case .phone: return "Phone"
            case .photo: return "Upload your photo"
            case .position: return "Position"
        }
    }
}

enum Positions: CaseIterable {
    case front
    case back
    case designer
    case qa

    var title: String {
        switch self {
            case .front: return "Front-end Developer"
            case .back: return "Back-end Developer"
            case .designer: return "UI/UX Designer"
            case .qa: return "QA Tester"
        }
    }

    var id: Int {
        switch self {
            case .front: return 1
            case .back: return 2
            case .designer: return 3
            case .qa: return 4
        }
    }
}
