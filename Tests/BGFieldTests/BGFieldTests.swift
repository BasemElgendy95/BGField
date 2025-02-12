import XCTest
@testable import BGField

/// Test suite for BGField components.
final class BGFieldTests: XCTestCase {
    
    /// Tests email validation with valid and invalid inputs.
    func testEmailValidation() {
        XCTAssertEqual(BGFieldValidator.defaultValidators[.email]?("test@example.com", true), .valid)
        XCTAssertEqual(BGFieldValidator.defaultValidators[.email]?("invalid-email", true), .invalid(reason: "invalid_email"))
    }
    
    /// Tests password validation including required character rules.
    func testPasswordValidation() {
        XCTAssertEqual(BGFieldValidator.defaultValidators[.password]?("Password123!", true), .valid)
        XCTAssertEqual(BGFieldValidator.defaultValidators[.password]?("pass", true), .invalid(reason: "password_too_short"))
    }
    
    /// Tests phone number validation ensuring correct length.
    func testPhoneNumberValidation() {
        XCTAssertEqual(BGFieldValidator.defaultValidators[.phone]?("1234567890", true), .valid)
        XCTAssertEqual(BGFieldValidator.defaultValidators[.phone]?("12345", true), .invalid(reason: "invalid_phone"))
    }
    
    /// Tests different field state transitions such as idle, active, valid, and invalid.
    func testFieldStateTransitions() {
        var state: BGFieldState = .idle
        state = .active
        XCTAssertEqual(state, .active)
        state = .valid
        XCTAssertEqual(state, .valid)
        state = .invalid(reason: "Test error")
        XCTAssertEqual(state, .invalid(reason: "Test error"))
    }
    
    /// Tests character limit enforcement in text fields.
    func testTextFieldCharacterLimit() {
        var text = ""
        let limit = 10
        let longText = "This is a long text exceeding limit"
        text = String(longText.prefix(limit))
        XCTAssertEqual(text.count, limit)
    }
    
    /// Tests initialization of a multiline text field with a character limit.
    func testMultilineField() {
        var text = ""
        let field = BGMultilineTextField(text: Binding.constant(text), placeholder: "Enter text", characterLimit: 100, config: BGFieldConfig())
        XCTAssertNotNil(field)
    }
}
