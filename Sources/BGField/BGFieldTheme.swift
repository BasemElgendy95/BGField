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
    var border: BGFieldBorderTheme
    var text: BGFieldTextTheme
    var cornerRadius: CGFloat
    var backgroundColor: Color

    /// The default theme applied to `BGField`.
    static let `default` = BGFieldTheme(
        border: .default,
        text: .default,
        cornerRadius: 0,
        backgroundColor: .clear
    )
    init(border: BGFieldBorderTheme, text: BGFieldTextTheme, cornerRadius: CGFloat, backgroundColor: Color) {
        self.border = border
        self.text = text
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}

/// Defines text styling within a `BGField`, including colors and font.
public struct BGFieldTextTheme: Sendable {
    var idleColor: Color
    var activeColor: Color
    var errorColor: Color
    var placeholderColor: Color
    var font: Font

    /// The default text theme for `BGField`.
    public static let `default` = BGFieldTextTheme(
        idleColor: .black,
        activeColor: .black,
        errorColor: .red,
        placeholderColor: .gray,
        font: .body
    )
    
    init(idleColor: Color, activeColor: Color, errorColor: Color, placeholderColor: Color, font: Font) {
        self.idleColor = idleColor
        self.activeColor = activeColor
        self.errorColor = errorColor
        self.placeholderColor = placeholderColor
        self.font = font
    }
}

/// Defines border styling for `BGField`, including color states and width.
public struct BGFieldBorderTheme: Sendable {
    var idleColor: Color
    var activeColor: Color
    var validColor: Color
    var errorColor: Color
    var width: CGFloat

    /// The default border theme for `BGField`.
    public static let `default` = BGFieldBorderTheme(
        idleColor: .gray,
        activeColor: .black,
        validColor: .green,
        errorColor: .red,
        width: 0
    )
    
    init(idleColor: Color, activeColor: Color, validColor: Color, errorColor: Color, width: CGFloat) {
        self.idleColor = idleColor
        self.activeColor = activeColor
        self.validColor = validColor
        self.errorColor = errorColor
        self.width = width
    }
}
