//
//  Chord.swift
//  Fretboard
//
//  Created by Huong Do on 23/01/2021.
//

import Foundation

struct Chord: Decodable {
    let key: String
    let baseFret: Int
    let barres: [Int]
    let frets: [Int]
    let suffix: String
    let fingers: [Int]
    let capo: Bool
    
    var chordName: String {
        if suffix.isEmpty {
            return key
        }
        return key + " " + suffix
    }
}

