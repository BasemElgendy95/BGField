//
//  BGKeyboard.swift
//  GoPod
//
//  Created by Basem's Dawarha Macbook on 03/08/2025.
//

import SwiftUI

/// A ViewModifier that dismisses the keyboard when the view is tapped.
public struct HideKeyboardOnTapModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
            )
    }
}

public extension View {
    /// Adds the ability to dismiss the keyboard when tapping on the view.
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTapModifier())
    }
}

