📦 BGField Package

🚀 Overview

BGField is a SwiftUI package that provides a customizable and flexible form field component for various input types, including text, email, password, phone number, date, and more. It supports validation, theming, and user interaction states.

✨ Features

✅ Support for multiple field types (email, password, phone, date, etc.).

🎨 Customizable themes for text styling and borders.

🔍 Field validation with built-in and custom rules.

📌 State management for idle, active, valid, invalid, and disabled states.

📝 Supports character limits and multiline text inputs.

📥 Installation

🛠 Using Swift Package Manager (SPM)

Open Xcode and navigate to your project.

Go to File > Swift Packages > Add Package Dependency.

Enter the repository URL and choose the latest version.

🏗 Usage

🔹 Basic Example

import SwiftUI
import BGField

struct ContentView: View {
    @State private var text: String = ""
    @State private var fieldState: BGFieldState = .idle
    
    var body: some View {
        BGField(
            text: $text,
            fieldState: $fieldState,
            fieldType: .email,
            placeholder: "📧 Enter your email",
            isRequired: true
        )
        .padding()
    }
}

🔠 Field Types

BGField supports the following types:

📧 .email – Email input with validation.

🔒 .password – Secure password input with strength indicator.

📞 .phone – Numeric input for phone numbers.

👤 .name – Text input for full names.

🆔 .username – Text input for usernames.

📅 .date – Date picker field.

🔢 .number – Numeric input field.

🔗 .url – URL input with validation.

📝 .multilineText – Text area supporting multiple lines.

✅ Validation

BGField includes built-in validation rules. Example:

let emailState = BGFieldValidator.defaultValidators[.email]?("test@example.com", true)
print(emailState) // Output: .valid

🎨 Customization

🎭 Theming

You can apply a custom theme to the fields:

BGFieldThemeManager.shared.theme = BGFieldTheme(
    border: BGFieldBorderTheme(idleColor: .gray, activeColor: .blue, validColor: .green, errorColor: .red, width: 2),
    text: BGFieldTextTheme(idleColor: .black, activeColor: .blue, errorColor: .red, placeholderColor: .gray, font: .body),
    cornerRadius: 8,
    backgroundColor: .white
)

🧪 Testing

Unit tests are included in the package under BGFieldTests. Run tests using:

swift test

📜 License

BGField is open-source and available under the MIT License. 📄

