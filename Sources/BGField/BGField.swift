//
//  BGField.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

/// A configurable text field view supporting multiple field types like password, multiline text, etc.
public struct BGField: BGfielded {
    @Binding private var text: String
    @Binding private var fieldState: BGFieldState
    @FocusState private var focusedField: BGFieldType?
    @State private var isPasswordVisible = false
    private let fieldType: BGFieldType
    private let placeholder: String
    private let isRequired: Bool
    private let characterLimit: Int?
    private let isMultiline: Bool
    
    private var config: BGFieldConfig {
        return configure(.init(border: .default, text: .default, cornerRadius: 10, backgroundColor: .accentColor))
    }

    /// Initializes a new `BGField`.
    /// - Parameters:
    ///   - text: A binding to the text input.
    ///   - fieldState: A binding to the field state.
    ///   - fieldType: The type of the field (e.g., `.password`, `.email`).
    ///   - placeholder: Placeholder text displayed when the field is empty.
    ///   - isRequired: Boolean indicating if the field is required.
    ///   - characterLimit: Optional limit for the maximum number of characters.
    ///   - isMultiline: Boolean indicating if the field should support multiline text.
    public init(
        text: Binding<String>,
        fieldState: Binding<BGFieldState>,
        fieldType: BGFieldType,
        placeholder: String,
        isRequired: Bool = false,
        characterLimit: Int? = nil,
        isMultiline: Bool = false
    ) {
        self._text = text
        self._fieldState = fieldState
        self.fieldType = fieldType
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.characterLimit = characterLimit
        self.isMultiline = isMultiline
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 5) {
                fieldView()
                if fieldType == .password {
                    togglePasswordVisibilityButton
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .stroke(borderColor, lineWidth: config.border.width)
                    .background(config.backgroundColor.cornerRadius(config.cornerRadius))
            )
            .font(config.text.font)
            .accessibilityLabel(Text(placeholder))
            .accessibilityHint(isRequired ? "Required field" : "Optional field")
            .accessibilityValue(Text(text))

            if let errorMessage = fieldState.errorMessage {
                errorText(errorMessage: errorMessage)
            }

            if let limit = characterLimit {
                limitText(limit: limit)
            }
        }
        .onChange(of: focusedField) {
            if focusedField == nil { validate() }
        }
        
    }
}

// MARK: - Field View Extensions

private extension BGField {
    @ViewBuilder
    func fieldView() -> some View {
        if isMultiline {
            multilineFieldView
        } else if fieldType == .password && !isPasswordVisible {
            passwordFieldView
        } else {
            normalFieldView
        }
    }

    var multilineFieldView: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(config.text.placeholderColor), axis: .vertical)
            .lineLimit(1...8)
            .focused($focusedField, equals: .multilineText)
            .onChange(of: text){ updateText(text)}
            .onSubmit { validate() }
    }

    var passwordFieldView: some View {
        Group {
            if isPasswordVisible {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(config.text.placeholderColor))
            } else {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(config.text.placeholderColor))
            }
        }
        .focused($focusedField, equals: .password)
        .onChange(of: text){ updateText(text)}
        .onSubmit { validate() }
    }

    var normalFieldView: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(config.text.placeholderColor))
            .focused($focusedField, equals: fieldType)
            .onChange(of: text){ updateText(text)}
            .onSubmit { validate() }
    }

    var togglePasswordVisibilityButton: some View {
        Button(action: { isPasswordVisible.toggle() }) {
            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                .foregroundColor(.gray)
                .accessibilityLabel(isPasswordVisible ? "Hide password" : "Show password")
        }
    }
}

// MARK: - Error and Limit Text Extensions

private extension BGField {
    @ViewBuilder
    func errorText(errorMessage: String) -> some View {
        Text(errorMessage)
            .foregroundColor(config.text.errorColor)
            .font(.caption)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: fieldState)
    }

    @ViewBuilder
    func limitText(limit: Int) -> some View {
        Text("\(text.count)/\(limit)")
            .font(.caption)
            .foregroundColor(.gray)
    }
}

// MARK: - Validation Extensions

private extension BGField {
    func updateText(_ newValue: String) {
        text = newValue
        fieldState = .active
        if let limit = characterLimit, newValue.count > limit {
            text = String(newValue.prefix(limit))
        }
    }

    func validate() {
        if let validator = BGFieldValidator.defaultValidators[fieldType] {
            withAnimation {
                fieldState = validator(text, isRequired)
            }
        }
    }

    var borderColor: Color {
        switch fieldState {
        case .idle: return config.border.idleColor
        case .valid: return config.border.validColor
        case .invalid: return config.border.errorColor
        default: return config.border.activeColor
        }
    }
}
