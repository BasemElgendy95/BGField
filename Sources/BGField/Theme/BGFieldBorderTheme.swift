//
//  BGFieldBorderTheme.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

/// Defines border styling for `BGField`, including color states and width.
public struct BGFieldBorderTheme: Sendable {
    public var idleColor: Color
    public var activeColor: Color
    public var validColor: Color
    public var errorColor: Color
    public var width: CGFloat

    /// The default border theme for `BGField`.
    public static let `default` = BGFieldBorderTheme(
        idleColor: .gray,
        activeColor: .black,
        validColor: .green,
        errorColor: .red,
        width: 1
    )
    
    public init(idleColor: Color, activeColor: Color, validColor: Color, errorColor: Color, width: CGFloat) {
        self.idleColor = idleColor
        self.activeColor = activeColor
        self.validColor = validColor
        self.errorColor = errorColor
        self.width = width
    }
}
