//
//  Array+GuitarChords.swift
//  
//
//  Created by Huong Do on 26/01/2021.
//

import Foundation

public extension Array where Element == GuitarChord {
    var keys: [Key] {
        self.map { $0.key }
    }
    
    var suffixes: [Suffix] {
        self.map { $0.suffix }
    }
    
    func matching(key: Key) -> [GuitarChord] {
        self.filter { $0.key == key }
    }
    
    func matching(suffix: Suffix) -> [GuitarChord] {
        self.filter { $0.suffix == suffix }
    }
}
