//
//  String+Extensions.swift
//  
//
//  Created by Basem's  Macbook on 07/11/2024.
//

import Foundation

extension String {

    var dataEncoded: Data {
        return self.data(using: .utf8)!
    }
    
    func isValidLanguage() -> Bool {
        let englishRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$")
        let arabicRegex = try! NSRegularExpression(pattern: "^[\\p{Arabic}&&[^\\p{N}]]+$", options: .caseInsensitive)
        
        let stringRange = NSRange(location: 0, length: self.removeWhitespace().utf16.count)
        
        // Check for whitespaces at the beginning or end of the string
        guard !(self.hasPrefix(" ") || self.hasSuffix(" ")) else {return false}
        
        let isEnglis = englishRegex.firstMatch(in: self.removeWhitespace(), options: [], range: stringRange) != nil
        let isArabic = arabicRegex.firstMatch(in: self.removeWhitespace(), options: [], range: stringRange) != nil
        
        return isEnglis || isArabic
        
    }
    
    func isValidEnglishLanguage() -> Bool {
        let englishRegex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9_.]+$")
        
        let stringRange = NSRange(location: 0, length: self.removeWhitespace().utf16.count)
        
        // Check for whitespaces at the beginning or end of the string
        guard !(self.hasPrefix(" ") || self.hasSuffix(" ")) else {return false}
        
        let isEnglis = englishRegex.firstMatch(in: self.removeWhitespace(), options: [], range: stringRange) != nil
        
        return isEnglis
        
    }
    
    func isValidCount(min: Int , max: Int) -> Bool {
        return self.trimmingWhitespace().count > min && self.trimmingWhitespace().count < max
    }
    
    func trimmingWhitespace() -> String {
        // Use the `trimmingCharacters(in:)` method of the `String` class to remove leading and trailing whitespace.
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Return the trimmed string.
        return trimmedString
    }
    func isValidWhiteSpace() -> Bool {
        let regex = try! NSRegularExpression(pattern: "\\s{2,}", options: [])
        return regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)).location == NSNotFound
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    var isoDate: Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(identifier: "EG")
        let date = formatter.date(from: self)
        return date ?? Date()
    }
}

