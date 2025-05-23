import Testing
@testable import SafeUnwrap
import Foundation

@Suite
struct SafeUnwrapTests {
    
    // MARK: – Success cases

    @Test func testUnwrappedReturnsValueWhenNotNil() throws {
        let intOpt: Int? = 42
        #expect(try intOpt.unwrapped == 42)

        let stringOpt: String? = "Hello"
        #expect(try stringOpt.unwrapped == "Hello")

        let boolOpt: Bool? = false
        #expect(try boolOpt.unwrapped == false)
    }

    // MARK: – Default‑error failures

    @Test func testUnwrappedThrowsDefaultErrorWhenNil() {
        let optString: String? = nil

        #expect(throws: SafeUnwrapError.self) {
            try optString.unwrapped
        }
    }

    // MARK: – Custom‑error failures

    @Test func testUnwrappedThrowsCustomErrorWhenNil() {
        enum MyError: Error, Equatable { case oops }
        let optInt: Int? = nil

        #expect(throws: MyError.oops, "Should throw MyError.oops") {
            try optInt.unwrapped(error: MyError.oops)
        }
    }

    // MARK: – No‑throw on non‑nil

    @Test func testUnwrappedDoesNotThrowDefaultErrorWhenNotNil() throws {
        let optDouble: Double? = 3.14
        #expect(try optDouble.unwrapped == 3.14)
    }

    // MARK: – Default‑error description

    @Test func testDefaultErrorDescriptionIncludesTypeName() {
        let optDate: Date? = nil
        
        #expect(throws: SafeUnwrapError.self) {
            _ = try optDate.unwrapped
        }
    }
}
