import XCTest
@testable import Fretboard

final class FretboardTests: XCTestCase {
    func testDecodingGuitarChords() {
        let chords = Instrument.guitar.chords.values
        XCTAssertFalse(chords.isEmpty, "🤬 Cannot decode guitar chords!")
    }
    
    func testDecodingUkuleleChords() {
        let chords = Instrument.ukulele.chords.values
        XCTAssertFalse(chords.isEmpty, "🤬 Cannot decode ukulele chords!")
    }
    
    static var allTests = [
        ("testDecodingGuitarChords", testDecodingGuitarChords),
        ("testDecodingUkuleleChords", testDecodingUkuleleChords)
    ]
}
