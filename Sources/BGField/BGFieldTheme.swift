//
//  BGFieldTheme.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

// MARK: - Theme Configuration

/// Represents the overall theme for `BGField`, including border, text, corner radius, and background color.
public struct BGFieldTheme: Sendable {
    public var border: BGFieldBorderTheme
    public var text: BGFieldTextTheme
    public var cornerRadius: CGFloat
    public var backgroundColor: Color

    /// The default theme applied to `BGField`.
    static let `default` = BGFieldTheme(
        border: .default,
        text: .default,
        cornerRadius: 10,
        backgroundColor: .white
    )
    public init(border: BGFieldBorderTheme, text: BGFieldTextTheme, cornerRadius: CGFloat, backgroundColor: Color) {
        self.border = border
        self.text = text
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}

public extension BGFieldTheme {
    /// Converts a theme to a `BGFieldConfig` for field usage.
    func toConfig() -> BGFieldConfig {
        BGFieldConfig(
            border: self.border,
            text: self.text,
            cornerRadius: self.cornerRadius,
            backgroundColor: self.backgroundColor
        )
    }
}
