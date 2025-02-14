import XCTest
@testable import Frames

class AddressLine2ValidatorTests: XCTestCase {

    func testValidationWhenTextIsEmptyThenShouldBeTrue() {
        let expectedType = BillingFormCell.addressLine2(nil)
        let text = ""
        let isValid = expectedType.validator.validate(value: text)
        XCTAssertFalse(isValid)
    }

    func testValidationWhenTextIsNonEmptyThenShouldBeFalse() {
        let expectedType = BillingFormCell.addressLine2(nil)
        let text = "addressLine2"
        let isValid = expectedType.validator.validate(value: text)
        XCTAssertTrue(isValid)
    }
}
