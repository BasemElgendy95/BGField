//
//  BGfielded.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

// MARK: - BGfielded Protocol

/// A protocol representing configurable field views.
public protocol BGfielded: View {
    /// Configures the appearance and behavior of the conforming view.
    /// - Parameter config: The configuration to apply.
    /// - Returns: A modified `BGFieldConfig` reflecting the new configuration.
    func configure(_ config: BGFieldConfig) -> BGFieldConfig
}

extension BGfielded {
    public func configure(_ config: BGFieldConfig) -> BGFieldConfig {
        config
    }
}
