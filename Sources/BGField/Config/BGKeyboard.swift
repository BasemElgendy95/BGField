//
//  BGKeyboard.swift
//  GoPod
//
//  Created by Basem's Dawarha Macbook on 03/08/2025.
//

import SwiftUI

/// A ViewModifier that dismisses the keyboard when the view is tapped.
struct HideKeyboardOnTapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}

extension View {
    /// Adds the ability to dismiss the keyboard when tapping on the view.
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTapModifier())
    }
}

