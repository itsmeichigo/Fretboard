//
//  FretboardView.swift
//  FretboardView
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

public struct FretboardView: View {
    let fingers: [Int]
    let frets: [Int]
    let barres: [Int]
    let baseFret: Int
    
    let fretLineCount: Int = 6
        
    public init(position: Chord.Position) {
        self.fingers = position.fingers
        self.frets = position.frets
        self.barres = position.barres
        self.baseFret = position.baseFret
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                setupStrings(with: proxy)
                setupFrets(with: proxy)
                
                ForEach(0..<frets.count, id: \.self) { index in
                    Group {
                        setupStringOverlay(at: index, with: proxy)
                        
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
                    setupCapo(for: proxy)
                    
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
    
    private func setupCapo(for proxy: GeometryProxy) -> some View {
        let barre = barres.first ?? 0
        let barreCount = frets.filter { $0 >= (barres.first ?? 0) }.count + frets.filter { $0 > 0 && $0 < barre }.count
        let width = gridWidth(for: proxy)
        let fretWidth = CGFloat(barreCount) * width
        let xOffset = CGFloat(frets.count - barreCount) * (width/2) * (frets[0] > 0 ? -1 : 1)
        
        return Group {
            if let barre = barres.first {
                Color.primary
                    .clipShape(Capsule())
                    .frame(width: fretWidth,
                           height: gridHeight(for: proxy)/2)
                    .offset(x: xOffset,
                            y: gridHeight(for: proxy) * CGFloat(barre - fretLineCount/2) + CGFloat(barre - fretLineCount/2))
            }
        }
    }
    
    private func gridWidth(for proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width / CGFloat(frets.count + 1)
    }
    
    private func gridHeight(for proxy: GeometryProxy) -> CGFloat {
        return proxy.size.height / CGFloat(fretLineCount + 1)
    }
    
    private func setupFrets(with proxy: GeometryProxy) -> some View {
        VStack(spacing: gridHeight(for: proxy)) {
            ForEach(0..<fretLineCount, id: \.self) { index in
                Group {
                    if index > 0 && index < frets.count {
                        Color.gray
                    } else {
                        Color.primary
                    }
                }
                .frame(width: gridWidth(for: proxy) * CGFloat(frets.count-1) + CGFloat(frets.count), height: 1)
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
            ForEach(frets, id: \.self) { s in
                Group {
                    if s >= 0 {
                        Color.primary
                    } else {
                        Color.gray
                    }
                }
                .frame(width: 1,
                       height: gridHeight(for: proxy) * CGFloat(fretLineCount - 1) + CGFloat(frets.count))
            }
        }
    }
    
    private func setupStringOverlay(at index: Int, with proxy: GeometryProxy) -> some View {
        Group {
            if shouldShowFingers(for: index) {
                Color.primary
                    .clipShape(Circle())
                    .padding(gridWidth(for: proxy)*0.1)
            } else if frets[index] < 0 {
                Text("✕")
                    .foregroundColor(.gray)
                    .font(.system(size: proxy.size.width/10))
            } else if frets[index] == 0 {
                Text("○")
                    .foregroundColor(.gray)
                    .font(.system(size: proxy.size.width/10))
            }
        }
        .frame(width: gridWidth(for: proxy),
               height: gridHeight(for: proxy),
               alignment: frets[index] <= 0 ? .bottom : .center)
        .offset(calculateOffset(index: index, proxy: proxy))
    }
    
    private func shouldShowFingers(for index: Int) -> Bool {
        return fingers[index] > 0 && (barres.isEmpty || (!barres.isEmpty && frets[index] != barres.first!))
    }
    
    private func calculateOffset(index: Int, proxy: GeometryProxy, isNumber: Bool = false) -> CGSize {
        let gridSize = CGSize(width: gridWidth(for: proxy),
                              height: gridHeight(for: proxy))
        let widthCenter = CGFloat(frets.count - 1) / 2.0
        let xOffset = gridSize.width * (CGFloat(index) - widthCenter) + (CGFloat(index) - widthCenter)
        if isNumber {
            let yOffset = gridSize.height * 3
            return CGSize(width: xOffset, height: yOffset)
        } else {
            let position = frets[index]
            let yOffset = gridSize.height * CGFloat(max(position, 0) - 3) + CGFloat(max(position, 0) - 3)
            return CGSize(width: xOffset, height: yOffset)
        }
        
    }
}

struct FretboardView_Previews: PreviewProvider {
    
    static let dAug9Chords = Instrument.guitar.findChordPositions(key: "D", suffix: "aug9")

    static let cMajorUkuChords = Instrument.ukulele.findChordPositions(key: "C", suffix: "major")
    
    static var previews: some View {
        Group {
            ForEach(dAug9Chords, id: \.self) {
                FretboardView(position: $0)
                    .frame(width: 100, height: 200)
            }
        }
    }
}
