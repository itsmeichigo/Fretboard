//
//  ContentView.swift
//  Demo
//
//  Created by Huong Do on 1/26/21.
//

import SwiftUI
import Fretboard

struct ContentView: View {
    var body: some View {
        VStack {
            Text("C Major")
                .font(.headline)
            
            FretView(fingers: [0, 3, 2, 0, 1, 0],
                     strings: [-1, 3, 2, 0, 1, 0],
                     barres: [])
                .frame(width: 100, height: 200)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
