//
//  BGEmailField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

public struct BGEmailField: View {
    @Binding var text: String
    
    var placeholder: LocalizedStringResource
    var config: BGFieldConfig

    public var body: some View {
        TextField("",
                  text: $text,
                  prompt: Text(placeholder).foregroundColor(config.text.placeholderColor).font(config.text.font))
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
}
