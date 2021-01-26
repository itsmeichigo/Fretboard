//
//  Array+GuitarChords.swift
//  
//
//  Created by Huong Do on 26/01/2021.
//

import Foundation

public extension Array where Element == GuitarChord {
    var keys: [GuitarChord.Key] {
        self.map { $0.key }
    }
    
    var suffixes: [GuitarChord.Suffix] {
        self.map { $0.suffix }
    }
    
    func matching(key: GuitarChord.Key) -> [GuitarChord] {
        self.filter { $0.key == key }
    }
    
    func matching(suffix: GuitarChord.Suffix) -> [GuitarChord] {
        self.filter { $0.suffix == suffix }
    }
}
