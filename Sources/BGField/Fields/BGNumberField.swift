//
//  BGNumberField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

public struct BGNumberField: View {
    @Binding var text: String
    var placeholder: String

    public var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(.decimalPad)
    }
}
