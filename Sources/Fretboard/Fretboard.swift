//
//  Fretboard.swift
//  Fretboard
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

struct Fretboard: View {
    let fingers: [Int]
    let strings: [Int]
    let barres: [Int]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let gridWidth = proxy.size.width / 7
                let gridHeight = proxy.size.height / 7
                
                VStack(spacing: gridHeight) {
                    ForEach(0..<strings.count, id: \.self) { index in
                        let stringColor: Color = (index > 0 && index < strings.count) ? .gray : .primary
                        let overlayColor: Color = (index == 0) ? .primary : .clear
                        stringColor
                            .frame(width: gridWidth*CGFloat(strings.count-1) + CGFloat(strings.count), height: 1)
                            .overlay(
                                overlayColor
                                    .frame(height: 3)
                            )
                    }
                }
                
                HStack(spacing: gridWidth) {
                    ForEach(strings, id: \.self) { s in
                        Group {
                            if s >= 0 {
                                Color.primary
                            } else {
                                Color.gray
                            }
                        }
                        .frame(width: 1, height: gridHeight*CGFloat(strings.count-1) + CGFloat(strings.count))
                    }
                }
                
                ForEach(0..<strings.count, id: \.self) { index in
                    let shouldShowFingers = (fingers[index] > 0 && barres.isEmpty) || (!barres.isEmpty && fingers[index] > barres.first!)

                    Group {
                        if shouldShowFingers {
                            Color.primary
                                .clipShape(Circle())
                                .padding(gridWidth*0.1)
                        } else if strings[index] < 0 {
                            Text("x")
                                .foregroundColor(.primary)
                                .font(.system(size: proxy.size.width/10))
                        }
                    }
                    .frame(width: gridWidth, height: gridHeight)
                    .offset(calculateOffset(index: index, fretSize: CGSize(width: gridWidth, height: gridHeight)))
                
                    Group {
                        if shouldShowFingers {
                            Text("\(fingers[index])")
                                .foregroundColor(.primary)
                                .font(.system(size: proxy.size.width/10))
                        }
                    }
                    .frame(width: gridWidth, height: gridHeight)
                    .offset(calculateOffset(index: index, fretSize: CGSize(width: gridWidth, height: gridHeight), isNumber: true))
                }
                
                Group {
                    if let bar = barres.first {
                        Color.primary
                            .clipShape(Capsule())
                            .frame(width: proxy.size.width*0.9, height: gridHeight*0.3)
                            .offset(CGSize(width: 0, height: gridHeight * CGFloat(bar - 3) + CGFloat(bar - 3)))

                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        
    }
    
    private func calculateOffset(index: Int, fretSize: CGSize, isNumber: Bool = false) -> CGSize {
        let xOffset = fretSize.width * (CGFloat(index) - 2.5) + (CGFloat(index) - 2.5)
        if isNumber {
            let yOffset = fretSize.height * 3
            return CGSize(width: xOffset, height: yOffset)
        } else {
            let position = strings[index]
            let yOffset = fretSize.height * CGFloat(max(position, 0) - 3) + CGFloat(position - 3)
            return CGSize(width: xOffset, height: yOffset)
        }
        
    }
}

struct Fretboard_Previews: PreviewProvider {
    static var previews: some View {
        Fretboard(fingers: [1, 3, 4, 2, 1, 1],
                 strings: [1, 3, 3, 2, 1, 1],
                 barres: [1])
            .frame(width: 100, height: 200)
    }
}
