//
//  BGDateField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

import SwiftUI

// MARK: - BGDateField

public struct BGDateField: View {
    @Binding var text: String
    var placeholder: String
    var onSubmit: (() -> Void)
    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $text)
                    .keyboardType(.numberPad)
                    .disabled(true)

                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        withAnimation {
                            showDatePicker.toggle()
                        }
                    }
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()

                Button("Done") {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    text = formatter.string(from: selectedDate)
                    showDatePicker = false
                    DispatchQueue.main.async {
                        onSubmit()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
            }
        }
    }
}
