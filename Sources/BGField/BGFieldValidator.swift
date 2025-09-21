//
//  BGFieldValidator.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

// MARK: - BGFieldValidator

public struct BGFieldValidator {
    @MainActor static let defaultValidators: [BGFieldType: @Sendable (String, Bool) -> BGFieldState] = [
        .email: { validateWithRegex($0, isRequired: $1, pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", errorMessage: String(localized: "invalid_email", bundle: .module)) },
        .phone: { validateWithRegex($0, isRequired: $1, pattern: "^\\d{10}$", errorMessage: String(localized: "invalid_phone", bundle: .module)) },
        .phoneWithCode: { validateWithRegex($0, isRequired: $1, pattern: "^\\d{10}$", errorMessage: String(localized: "invalid_phone", bundle: .module)) },
        .password: { validatePassword($0, isRequired: $1) },
        .name: { validateWithRegex($0, isRequired: $1, pattern: "^[A-Za-z ]{2,}$", errorMessage: String(localized: "name_too_short", bundle: .module)) },
        .username: { validateWithRegex($0, isRequired: $1, pattern: "^[a-zA-Z0-9_]{3,}$", errorMessage: String(localized: "invalid_username", bundle: .module)) },
        .multilineText: { validateFreeText($0, isRequired: $1) },
        .date: { validateDate($0, isRequired: $1) },
        .number: { validateWithRegex($0, isRequired: $1, pattern: "^\\d+$", errorMessage: String(localized: "invalid_number", bundle: .module)) },
        .url: { validateWithRegex($0, isRequired: $1, pattern: "^(https?|ftp)://[^\\s/$.?#].[^\\s]*$", errorMessage: String(localized: "invalid_url", bundle: .module)) }
    ]

    private static func validateWithRegex(_ text: String, isRequired: Bool, pattern: String, errorMessage: String) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: String(localized: "field_required", bundle: .module)) }
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) != nil ? .valid : .invalid(reason: errorMessage)
    }

    private static func validatePassword(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: String(localized: "password_required", bundle: .module)) }
        if text.count < 8 {
            return .invalid(reason: String(localized: "password_too_short", bundle: .module))
        }
        if !text.contains(where: { $0.isUppercase }) {
            return .invalid(reason: String(localized: "password_uppercase_required", bundle: .module))
        }
        if !text.contains(where: { $0.isLowercase }) {
            return .invalid(reason: String(localized: "password_lowercase_required", bundle: .module))
        }
        if !text.contains(where: { $0.isNumber }) {
            return .invalid(reason: String(localized: "password_number_required", bundle: .module))
        }
        if text.rangeOfCharacter(from: CharacterSet.punctuationCharacters) == nil {
            return .invalid(reason: String(localized: "password_special_required", bundle: .module))
        }
        return .valid
    }

    private static func validateFreeText(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: String(localized: "field_required", bundle: .module)) }
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .invalid(reason: String(localized: "invalid_text", bundle: .module)) : .valid
    }

    private static func validateDate(_ text: String, isRequired: Bool) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: String(localized: "field_required", bundle: .module)) }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: text) != nil ? .valid : .invalid(reason: String(localized: "invalid_date_format", bundle: .module))
    }

    // Support for Custom Validators
    public static func customValidator(_ text: String, isRequired: Bool, validation: (String) -> Bool, errorMessage: String) -> BGFieldState {
        guard !isRequired || !text.isEmpty else { return .invalid(reason: String(localized: "field_required", bundle: .module)) }
        return validation(text) ? .valid : .invalid(reason: errorMessage)
    }
}

