//
//  ContentView.swift
//  Demo
//
//  Created by Huong Do on 1/26/21.
//

import SwiftUI
import Fretboard

struct ContentView: View {
    @State private var selectedKey: GuitarChord.Key = .c
    @State private var selectedSuffix: GuitarChord.Suffix = .major
    
    private let allChords: [GuitarChord]
    private let allKeys: [GuitarChord.Key]
    private let allSuffixes: [GuitarChord.Suffix]
    
    private var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 4)
    private var foundChords: [GuitarChord] {
        allChords.matching(key: selectedKey)
            .matching(suffix: selectedSuffix)
    }
    
    init() {
        allChords = GuitarChord.all
        allKeys = Array(Set(allChords.keys))
        allSuffixes = Array(Set(allChords.suffixes))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Guitar Chord Lookup 🎸")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Picker("Select key", selection: $selectedKey) {
                        ForEach(allKeys, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Select suffix", selection: $selectedSuffix) {
                        ForEach(allSuffixes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                LazyVGrid(columns: columns) {
                    ForEach(foundChords, id: \.self) { chord in
                        FretView(chord: chord)
                            .frame(width: 100, height: 200)
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: 500, height: 300)
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
