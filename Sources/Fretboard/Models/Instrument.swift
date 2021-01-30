//
//  Instrument.swift
//  
//
//  Created by Huong Do on 30/01/2021.
//

import Foundation

public struct Instrument: Decodable {
    public let keys: [String]
    public let suffixes: [String]
    public let chords: [String: [Chord]]
}

extension Instrument {
    public static let guitar = instrument(from: "guitar")
    public static let ukulele = instrument(from: "ukulele")
    
    public func findChordPositions(key: String, suffix: String) -> [Chord.Position] {
        chords[key]?.first(where: { $0.suffix == suffix })?.positions ?? []
    }
    
    static func instrument(from resource: String) -> Instrument {
        let url = Bundle.module.url(forResource: resource, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return try! JSONDecoder().decode(Instrument.self, from: data)
    }
}
