import XCTest
@testable import Fretboard

final class FretboardTests: XCTestCase {
    func testDecodingGuitarChords() {
        let chords = GuitarChord.all
        XCTAssertFalse(chords.isEmpty, "🤬 Cannot decode guitar chords!")
    }

    static var allTests = [
        ("testDecodingGuitarChords", testDecodingGuitarChords),
    ]
}
