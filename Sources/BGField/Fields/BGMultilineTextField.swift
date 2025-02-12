//
//  BGMultilineTextField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

public struct BGMultilineTextField: View {
    @Binding var text: String
    var placeholder: String
    var characterLimit: Int?
    var config: BGFieldConfig
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(config.text.placeholderColor), axis: .vertical)
                .lineLimit(1...8)
            if let limit = characterLimit {
                limitText(limit: limit)
            }
        }
    }
    
    @ViewBuilder
    func limitText(limit: Int) -> some View {
        Text("\(text.count)/\(limit)")
            .font(.caption)
            .foregroundColor(.gray)
    }

}
