import XCTest
@testable import Fretboard

final class FretboardTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Fretboard().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
