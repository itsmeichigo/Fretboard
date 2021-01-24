//
//  ChordView.swift
//  Fretboard
//
//  Created by Huong Do on 24/01/2021.
//

import SwiftUI

struct ChordView: View {
    let chord: Chord
    var body: some View {
        VStack(spacing: 40) {
            Text(chord.chordName)
                .font(.largeTitle)
            FretView(fingers: chord.fingers,
                     strings: chord.frets,
                     barres: chord.barres)
                .frame(width: 100, height: 200)
            if chord.baseFret > 1 {
                Text("Fret \(chord.baseFret)")
                    .font(.headline)
            }
        }
    }
}

struct ChordView_Previews: PreviewProvider {
    static var previews: some View {
        let chord = Chord(key: "F",
                          baseFret: 1,
                          barres: [1],
                          frets: [1, 3, 3, 2, 1, 1],
                          suffix: "major",
                          fingers: [1, 3, 4, 2, 1, 1],
                          capo: true)
        return ChordView(chord: chord)
    }
}
