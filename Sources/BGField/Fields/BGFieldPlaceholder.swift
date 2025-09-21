//
//  BGEmailField 2.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 21/09/2025.
//
import SwiftUI

public struct BGFieldPlaceholder: View {
    
    var placeholder: String

    var config: BGFieldConfig

    public var body: some View {
        Text(placeholder)
            .foregroundColor(config.text.placeholderColor)
    }
}
