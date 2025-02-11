//
//  BGFieldValidator.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import Foundation

public struct BGFieldValidator {
    @MainActor static let defaultValidators: [BGFieldType: @Sendable (String, Bool) -> BGFieldState] = [
        .email: { validateEmail($0, isRequired: $1) },
        .phone: { validatePhone($0, isRequired: $1) },
        .password: { validatePassword($0, isRequired: $1) },
        .name: { validateName($0, isRequired: $1) },
        .username: { validateUsername($0, isRequired: $1) },
        .multilineText: { validateFreeText($0, isRequired: $1) },
            
    ]

    static func validateEmail(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return text.contains("@") ? .valid : .invalid(reason: "Invalid email")
    }

    static func validatePhone(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return text.count == 10 ? .valid : .invalid(reason: "Invalid phone number")
    }

    static func validatePassword(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return text.count >= 8 ? .valid : .invalid(reason: "Password too short")
    }

    static func validateName(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return text.count > 1 ? .valid : .invalid(reason: "Name too short")
    }

    static func validateUsername(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return !text.isEmpty ? .valid : .invalid(reason: "Username required")
    }
    
    static func validateFreeText(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: "This field is required") }
        return !text.isEmpty ? .valid : .invalid(reason: "Invalid text")
    }
}
