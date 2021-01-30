//
//  ContentView.swift
//  Demo
//
//  Created by Huong Do on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedInstrument: Instrument = .guitar
    @State private var selectedKey: String = "C"
    @State private var selectedSuffix: String = "major"
    
    private var columns: [GridItem] =
                 Array(repeating: .init(.flexible()), count: 4)

    private let instruments = [Instrument.guitar, Instrument.ukulele]
    
    private var foundChords: [Chord.Position] {
        selectedInstrument.findChordPositions(key: selectedKey, suffix: selectedSuffix)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Fretboard")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Picker("Instrument", selection: $selectedInstrument) {
                        ForEach(instruments, id: \.self) {
                            Text($0.name.capitalized(with: nil))
                        }
                    }
                    
                    Picker("Key", selection: $selectedKey) {
                        ForEach(selectedInstrument.keys, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Suffix", selection: $selectedSuffix) {
                        ForEach(selectedInstrument.suffixes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                LazyVGrid(columns: columns) {
                    ForEach(foundChords, id: \.self) { position in
                        FretboardView(position: position)
                            .frame(width: 100, height: 200)
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: 500, height: 400)
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

