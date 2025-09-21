//
//  BGFieldType.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import Foundation

// MARK: - BGFieldType

/// Represents different types of form fields.
public enum BGFieldType: Hashable, CaseIterable {
    case email          // Field type for email addresses.
    case password       // Field type for passwords.
    case multilineText  // Field type for multi-line text inputs.
    case phone          // Field type for phone numbers.
    case phoneWithCode  // Field type for phone numbers with country/region code.
    case name           // Field type for names.
    case username       // Field type for usernames.
    case date           // Field type for date inputs.
    case number         // Field type for numerical inputs.
    case url            // Field type for URLs.

    /// Provides a description of each field type.
    public var description: String {
        switch self {
        case .email: return "Email Address"
        case .password: return "Password"
        case .multilineText: return "Multiline Text"
        case .phone: return "Phone Number"
        case .phoneWithCode: return "Phone Number (with Code)"
        case .name: return "Full Name"
        case .username: return "Username"
        case .date: return "Date"
        case .number: return "Number"
        case .url: return "Website URL"
        }
    }
}

