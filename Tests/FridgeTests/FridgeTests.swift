import XCTest
@testable import Fridge

final class FridgeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Fridge().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
