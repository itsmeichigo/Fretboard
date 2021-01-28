//
//  GuitarChord.swift
//  Fretboard
//
//  Created by Huong Do on 23/01/2021.
//

import Foundation

public struct GuitarChord: Chord, Decodable, Hashable, Equatable {
    public let key: Key
    public let baseFret: Int
    public let barres: [Int]
    public let frets: [Int]
    public let suffix: Suffix
    public let fingers: [Int]
    
    public static let all: [GuitarChord] = {
        guard let chordsUrl = Bundle.module.url(forResource: "chords", withExtension: "json"),
              let data = try? Data(contentsOf: chordsUrl) else {
            #if DEBUG
            print("Chord data corrupted or not found")
            #endif
            return []
        }
        do {
            let allChords = try JSONDecoder().decode([GuitarChord].self, from: data)
            return allChords
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
        return []
    }()
}

