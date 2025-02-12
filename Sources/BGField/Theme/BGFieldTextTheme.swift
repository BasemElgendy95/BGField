//
//  BGFieldTextTheme.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

/// Defines text styling within a `BGField`, including colors and font.
public struct BGFieldTextTheme: Sendable {
    public var idleColor: Color
    public var activeColor: Color
    public var errorColor: Color
    public var placeholderColor: Color
    public var font: Font

    /// The default text theme for `BGField`.
    public static let `default` = BGFieldTextTheme(
        idleColor: .black,
        activeColor: .black,
        errorColor: .red,
        placeholderColor: .gray,
        font: .body
    )
    
    public init(idleColor: Color, activeColor: Color, errorColor: Color, placeholderColor: Color, font: Font) {
        self.idleColor = idleColor
        self.activeColor = activeColor
        self.errorColor = errorColor
        self.placeholderColor = placeholderColor
        self.font = font
    }
}

