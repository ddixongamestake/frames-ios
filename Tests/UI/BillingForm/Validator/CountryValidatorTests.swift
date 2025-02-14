import XCTest
@testable import Frames

class CountryValidatorTests: XCTestCase {

    func testValidationWhenTextIsEmptyThenShouldBeTrue() {
        let expectedType = BillingFormCell.country(nil)
        let text = ""
        let isValid = expectedType.validator.validate(value: text)
        XCTAssertFalse(isValid)
    }

    func testValidationWhenTextIsNonEmptyThenShouldBeFalse() {
        let expectedType = BillingFormCell.country(nil)
        let text = "Country"
        let isValid = expectedType.validator.validate(value: text)
        XCTAssertTrue(isValid)
    }
}
