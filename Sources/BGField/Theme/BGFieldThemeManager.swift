//
//  BGfielded.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

/// Manages the global theme for BGField components.
public class BGFieldThemeManager: ObservableObject {
    @MainActor public static let shared = BGFieldThemeManager()
    
    @Published public var theme: BGFieldTheme = .default
    
    private init() {}
}

