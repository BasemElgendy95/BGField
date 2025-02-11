//
//  BGFieldState.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import Foundation

// MARK: - BGFieldState

/// Represents the state of a form field in the UI.
/// This enum helps manage different UI states such as idle, active, valid, invalid, and disabled.
public enum BGFieldState: Equatable {
    case idle       // The field is in its initial state.
    case active     // The field is currently being interacted with user.
    case valid      // The input is valid according to the validation criteria.
    case invalid(reason: String?)  // The input is invalid with an optional reason.
    case disabled   // The field is currently disabled.

    /// Indicates if the field is in a valid state.
    public var isValid: Bool { self == .valid }

    /// Provides the error message if the field is invalid.
    public var errorMessage: String? {
        if case .invalid(let reason) = self {
            return reason
        }
        return nil
    }
}
