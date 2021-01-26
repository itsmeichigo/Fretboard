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
    
    public init(chord: GuitarChord) {
        self.fingers = chord.fingers
        self.strings = chord.frets
        self.barres = chord.barres
        self.baseFret = chord.baseFret
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                setupFret(with: proxy)
                setupStrings(with: proxy)
                
                ForEach(0..<strings.count, id: \.self) { index in
                    Group {
                        Group {
                            if shouldShowFingers(for: index) {
                                Color.primary
                                    .clipShape(Circle())
                                    .padding((proxy.size.width/7)*0.1)
                            } else if strings[index] < 0 {
                                Text("x")
                                    .foregroundColor(.gray)
                                    .font(.system(size: proxy.size.width/10))
                            }
                        }
                        .frame(width: proxy.size.width/7, height: proxy.size.height/7, alignment: strings[index] < 0 ? .bottom : .center)
                        .offset(calculateOffset(index: index, gridSize: CGSize(width: proxy.size.width/7, height: proxy.size.height/7)))
                    
                        if shouldShowFingers(for: index) {
                            Text("\(fingers[index])")
                                .foregroundColor(.primary)
                                .font(.system(size: proxy.size.width/10))
                                .frame(width: proxy.size.width/7, height: proxy.size.height/7)
                                .offset(calculateOffset(index: index, gridSize: CGSize(width: proxy.size.width/7, height: proxy.size.height/7), isNumber: true))
                        }
                    }
                }
                
                Group {
                    if let bar = barres.first {
                        Color.primary
                            .clipShape(Capsule())
                            .frame(width: proxy.size.width*0.9, height: (proxy.size.height/7)*0.3)
                            .offset(CGSize(width: 0, height: (proxy.size.height/7) * CGFloat(bar - 3) + CGFloat(bar - 3)))

                    }
                    
                    if baseFret > 1 {
                        Text("\(baseFret)fr")
                            .foregroundColor(.primary)
                            .font(.system(size: proxy.size.width/10))
                            .frame(width: proxy.size.width/7, height: proxy.size.height/7)
                            .offset(CGSize(width: 0, height: -(proxy.size.height/7) * 3.0 - 3))
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    private func setupStrings(with proxy: GeometryProxy) -> some View {
        VStack(spacing: proxy.size.height/7) {
            ForEach(0..<strings.count, id: \.self) { index in
                Group {
                    if index > 0 && index < strings.count {
                        Color.gray
                    } else {
                        Color.primary
                    }
                }
                .frame(width: (proxy.size.width/7) * CGFloat(strings.count-1) + CGFloat(strings.count), height: 1)
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
    
    private func setupFret(with proxy: GeometryProxy) -> some View {
        HStack(spacing: proxy.size.width/7) {
            ForEach(strings, id: \.self) { s in
                Group {
                    if s >= 0 {
                        Color.primary
                    } else {
                        Color.gray
                    }
                }
                .frame(width: 1, height: (proxy.size.height/7) * CGFloat(strings.count-1) + CGFloat(strings.count))
            }
        }
    }
    
    private func shouldShowFingers(for index: Int) -> Bool {
        return (fingers[index] > 0 && barres.isEmpty) || (!barres.isEmpty && fingers[index] > barres.first!)
    }
    
    private func calculateOffset(index: Int, gridSize: CGSize, isNumber: Bool = false) -> CGSize {
        let xOffset = gridSize.width * (CGFloat(index) - 2.5) + (CGFloat(index) - 2.5)
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
    static let fMajor = GuitarChord(key: .f, baseFret: 1, barres: [1], frets: [1, 3, 3, 2, 1, 1], suffix: .major, fingers: [1, 3, 4, 2, 1, 1])
    
    static let fAug = GuitarChord(key: .f, baseFret: 8, barres: [], frets: [-1, 1, -1, 3, 3, 2], suffix: .aug, fingers: [0, 1, 0, 3, 4, 2])
    
    static var previews: some View {
        Group {
            FretView(chord: fMajor)
                .frame(width: 100, height: 200)
            
            FretView(chord: fAug)
                .frame(width: 100, height: 200)
        }
        
    }
}
