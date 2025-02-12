//
//  BGFieldConfig.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//


import SwiftUI

// MARK: - BGFieldConfig

/// A configuration object for customizing the appearance and behavior of `BGField`.
public struct BGFieldConfig: Configurable {
    private(set) var border: BGFieldBorderTheme = .default
    private(set) var text: BGFieldTextTheme = .default
    private(set) var cornerRadius: CGFloat = 0
    private(set) var backgroundColor: Color = .white
}

public extension BGFieldConfig {

    /// Sets the border theme configuration for the field.
    /// - Parameter borderTheme: The border theme to apply. Defaults to `.defaultTheme`.
    /// - Returns: A new `BGFieldConfig` instance with the updated border configuration.
    func border(_ borderTheme: BGFieldBorderTheme = .default) -> Self {
        changing(path: \.border, to: borderTheme)
    }

    /// Sets the text theme configuration for the field.
    /// - Parameter textTheme: The text theme to apply. Defaults to `.defaultTheme`.
    /// - Returns: A new `BGFieldConfig` instance with the updated text configuration.
    func text(_ textTheme: BGFieldTextTheme = .default) -> Self {
        changing(path: \.text, to: textTheme)
    }

    /// Sets the corner radius of the field.
    /// - Parameter radius: The corner radius to apply. Defaults to `0.0`.
    /// - Returns: A new `BGFieldConfig` instance with the updated corner radius.
    func cornerRadius(_ radius: CGFloat = 0.0) -> Self {
        changing(path: \.cornerRadius, to: radius)
    }

    /// Sets the background color of the field.
    /// - Parameter color: The background color to apply. Defaults to `.clear`.
    /// - Returns: A new `BGFieldConfig` instance with the updated background color.
    func backgroundColor(_ color: Color = .clear) -> Self {
        changing(path: \.backgroundColor, to: color)
    }
}
