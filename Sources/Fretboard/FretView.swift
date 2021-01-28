//
//  FretView.swift
//  FretView
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

public struct FretView: View {
    let fingers: [Int]
    let strings: [Int]
    let barres: [Int]
    let baseFret: Int
    
    let fretLineCount: Int = 6
        
    public init(chord: Chord) {
        self.fingers = chord.fingers
        self.strings = chord.frets
        self.barres = chord.barres
        self.baseFret = chord.baseFret
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                setupStrings(with: proxy)
                setupFret(with: proxy)
                
                ForEach(0..<strings.count, id: \.self) { index in
                    Group {
                        Group {
                            if shouldShowFingers(for: index) {
                                Color.primary
                                    .clipShape(Circle())
                                    .padding(gridWidth(for: proxy)*0.1)
                            } else if strings[index] < 0 {
                                Text("x")
                                    .foregroundColor(.gray)
                                    .font(.system(size: proxy.size.width/10))
                            }
                        }
                        .frame(width: gridWidth(for: proxy),
                               height: gridHeight(for: proxy),
                               alignment: strings[index] < 0 ? .bottom : .center)
                        .offset(calculateOffset(index: index, proxy: proxy))
                    
                        if shouldShowFingers(for: index) {
                            Text("\(fingers[index])")
                                .foregroundColor(.primary)
                                .font(.system(size: proxy.size.width/10))
                                .frame(width: gridWidth(for: proxy),
                                       height: gridHeight(for: proxy))
                                .offset(calculateOffset(index: index, proxy: proxy, isNumber: true))
                        }
                    }
                }
                
                Group {
                    if let bar = barres.first {
                        Color.primary
                            .clipShape(Capsule())
                            .frame(width: proxy.size.width*0.9,
                                   height: gridHeight(for: proxy)*0.3)
                            .offset(y: gridHeight(for: proxy) * CGFloat(bar - fretLineCount/2) + CGFloat(bar - fretLineCount/2))

                    }
                    
                    if baseFret > 1 {
                        Text("\(baseFret)fr")
                            .foregroundColor(.primary)
                            .font(.system(size: proxy.size.width/10))
                            .frame(height: gridHeight(for: proxy))
                            .offset(y: -gridHeight(for: proxy) * 3.0 - 3)
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    private func gridWidth(for proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width / CGFloat(strings.count + 1)
    }
    
    private func gridHeight(for proxy: GeometryProxy) -> CGFloat {
        return proxy.size.height / CGFloat(fretLineCount + 1)
    }
    
    private func setupFret(with proxy: GeometryProxy) -> some View {
        VStack(spacing: gridHeight(for: proxy)) {
            ForEach(0..<fretLineCount, id: \.self) { index in
                Group {
                    if index > 0 && index < strings.count {
                        Color.gray
                    } else {
                        Color.primary
                    }
                }
                .frame(width: gridWidth(for: proxy) * CGFloat(strings.count-1) + CGFloat(strings.count), height: 1)
                .overlay(
                    Group {
                        if index == 0 {
                            Color.primary
                        } else {
                            Color.clear
                        }
                    }
                    .frame(height: 3)
                )
            }
        }
    }
    
    private func setupStrings(with proxy: GeometryProxy) -> some View {
        HStack(spacing: gridWidth(for: proxy)) {
            ForEach(strings, id: \.self) { s in
                Group {
                    if s >= 0 {
                        Color.primary
                    } else {
                        Color.gray
                    }
                }
                .frame(width: 1,
                       height: gridHeight(for: proxy) * CGFloat(fretLineCount - 1) + CGFloat(strings.count))
            }
        }
    }
    
    private func shouldShowFingers(for index: Int) -> Bool {
        return (fingers[index] > 0 && barres.isEmpty) || (!barres.isEmpty && fingers[index] > barres.first!)
    }
    
    private func calculateOffset(index: Int, proxy: GeometryProxy, isNumber: Bool = false) -> CGSize {
        let gridSize = CGSize(width: gridWidth(for: proxy),
                              height: gridHeight(for: proxy))
        let widthCenter = CGFloat(strings.count - 1) / 2.0
        let xOffset = gridSize.width * (CGFloat(index) - widthCenter) + (CGFloat(index) - widthCenter)
        if isNumber {
            let yOffset = gridSize.height * 3
            return CGSize(width: xOffset, height: yOffset)
        } else {
            let position = strings[index]
            let yOffset = gridSize.height * CGFloat(max(position, 0) - 3) + CGFloat(max(position, 0) - 3)
            return CGSize(width: xOffset, height: yOffset)
        }
        
    }
}

struct FretView_Previews: PreviewProvider {
    struct Ukulele: Chord {
        let key: Key
        let baseFret: Int
        let barres: [Int]
        let frets: [Int]
        let suffix: Suffix
        let fingers: [Int]
    }
    
    static let fMajor = GuitarChord(key: .f, baseFret: 1, barres: [1], frets: [1, 3, 3, 2, 1, 1], suffix: .major, fingers: [1, 3, 4, 2, 1, 1])
    
    static let fAug = GuitarChord(key: .f, baseFret: 8, barres: [], frets: [-1, 1, -1, 3, 3, 2], suffix: .aug, fingers: [0, 1, 0, 3, 4, 2])
    
    static let bbM9 = GuitarChord(key: .bFlat, baseFret: 11, barres: [], frets: [-1, 3, 1, 3, 3, -1], suffix: .majorNine, fingers: [0, 2, 1, 3, 4, 0])
    
    static let ukuC = Ukulele(key: .c, baseFret: 1, barres: [], frets: [0, 0, 0, 3], suffix: .major, fingers: [0, 0, 0, 3])
    
    static var previews: some View {
        Group {
            FretView(chord: fMajor)
                .frame(width: 100, height: 200)
            
            FretView(chord: fAug)
                .frame(width: 100, height: 200)
            
            FretView(chord: bbM9)
                .frame(width: 100, height: 200)
            
            FretView(chord: ukuC)
                .frame(width: 100, height: 200)
        }
        
    }
}
