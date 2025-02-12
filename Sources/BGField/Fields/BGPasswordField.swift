//
//  BGPasswordField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

public struct BGPasswordField: View {
    @Binding var text: String
    var placeholder: String
    @State private var isSecure = true

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            HStack {
                Group {
                    if isSecure {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            passwordStrengthIndicator
        }
        
    }
    
    @ViewBuilder
       var passwordStrengthIndicator: some View {
           if !text.isEmpty {
               let strength = calculatePasswordStrength(text)
               let color: Color = strength.color

               Text("Password Strength: \(strength.description)")
                   .font(.caption)
                   .foregroundColor(color)
                   .transition(.opacity)
                   .animation(.easeInOut(duration: 0.3), value: text)
           }

       }

       private func calculatePasswordStrength(_ password: String) -> (description: String, color: Color) {
           let lengthScore = password.count >= 12 ? 2 : (password.count >= 8 ? 1 : 0)
           let hasUppercase = password.contains { $0.isUppercase } ? 1 : 0
           let hasLowercase = password.contains { $0.isLowercase } ? 1 : 0
           let hasNumber = password.contains { $0.isNumber } ? 1 : 0
           let hasSpecialChar = password.rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil ? 1 : 0

           let score = lengthScore + hasUppercase + hasLowercase + hasNumber + hasSpecialChar

           switch score {
           case 5: return ("Very Strong", .green)
           case 4: return ("Strong", .green)
           case 3: return ("Medium", .yellow)
           default: return ("Weak", .red)
           }
       }
}
