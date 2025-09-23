//
//  BGField.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import SwiftUI

/// A configurable text field view supporting multiple field types like password, multiline text, etc.
public struct BGField: View {
    
    @Binding private var text: String
    @Binding private var fieldState: BGFieldState
    @FocusState private var focusedField: BGFieldType?
    @State private var isPasswordVisible = false
    
    private var customConfig: BGFieldConfig?
    private let fieldType: BGFieldType
    private let placeholder: LocalizedStringResource
    private let isRequired: Bool
    private let characterLimit: Int?
    private let isMultiline: Bool
    private let validator: ((String) -> BGFieldState)?
    
    private var config: BGFieldConfig =  BGFieldThemeManager.shared.theme.toConfig()
    
    private var borderColor: Color {
        switch fieldState {
        case .idle: return config.border.idleColor
        case .valid: return config.border.validColor
        case .invalid: return config.border.errorColor
        default: return config.border.activeColor
        }
    }
    public init(
        text: Binding<String>,
        fieldState: Binding<BGFieldState>,
        fieldType: BGFieldType,
        placeholder: LocalizedStringResource,
        isRequired: Bool = false,
        characterLimit: Int? = nil,
        isMultiline: Bool = false,
        config: BGFieldConfig? = nil,
        validator: ((String) -> BGFieldState)? = nil
    ) {
        self._text = text
        self._fieldState = fieldState
        self.fieldType = fieldType
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.characterLimit = characterLimit ?? (fieldType == .phoneWithCode ? 10 : nil)
        self.isMultiline = isMultiline
        self.customConfig = config
        self.validator = validator
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            fieldView()
                .focused($focusedField, equals: fieldType)
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

        
        }
        .onChange(of: focusedField) {
            if focusedField == nil { validate() }
        }
        .onChange(of: text) { updateText(text) }
        .onSubmit { validate() }
        .environment(
            \EnvironmentValues.layoutDirection,
             Locale.current.language.languageCode?.identifier == "ar" ? .rightToLeft : .leftToRight
        )
    }
}

// MARK: - Field View Extensions

private extension BGField {
    @ViewBuilder
    func fieldView() -> some View {
        switch fieldType {
        case .multilineText:
            BGMultilineTextField(text: $text, placeholder: placeholder, characterLimit: characterLimit, config: config)
        case .password:
            BGPasswordField(text: $text, placeholder: placeholder, config: config)
        case .name:
            BGNameField(text: $text, placeholder: placeholder, config: config)
        case .email:
            BGEmailField(text: $text, placeholder: placeholder, config: config)
        case .date:
            BGDateField(text: $text, placeholder: placeholder, config: config, onSubmit: {
                validate()
            })
        case .number:
            BGNumberField(text: $text, placeholder: placeholder, config: config)
        case .phoneWithCode:
            BGPhoneWithCodeField(text: $text, placeholder: placeholder, config: config)
        default:
            BGNameField(text: $text, placeholder: placeholder, config: config)
        }
        
    }
}

public extension BGField {
    func setBackgroundColor(_ color: Color) -> Self{
        let copy = self
        _ = copy.config.backgroundColor(color)
        return copy
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
        
        if fieldType == .phoneWithCode {
            if text.starts(with: "0") {
                text = String(newValue.dropFirst())
            }
        }
    }

    func validate() {
        if let customValidator = validator {
            withAnimation { fieldState = customValidator(text) }
        } else if let defaultValidator = BGFieldValidator.defaultValidators[fieldType] {
            withAnimation { fieldState = defaultValidator(text, isRequired) }
        }
    }
}

// MARK: - Error

private extension BGField {
    @ViewBuilder
    func errorText(errorMessage: String) -> some View {
        Text(errorMessage)
            .foregroundColor(config.text.errorColor)
            .font(.caption)
            .padding(.leading, 12)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: fieldState)
            
    }
}
