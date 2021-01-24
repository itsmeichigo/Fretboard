//
//  FretView.swift
//  Fretboard
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

struct FretView: View {
    let fingers: [Int]
    let strings: [Int]
    let barres: [Int]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: proxy.size.height/5) {
                    ForEach(0...5, id: \.self) { index in
                        let stringColor: Color = (index > 0 && index < 5) ? .gray : .black
                        let overlayColor: Color = (index == 0) ? .black : .clear
                        stringColor
                            .frame(height: 1)
                            .overlay(
                                overlayColor
                                    .frame(height: 3)
                            )
                    }
                }
                
                HStack(spacing: proxy.size.width/5) {
                    ForEach(strings, id: \.self) { s in
                        Group {
                            if s >= 0 {
                                Color.black
                            } else {
                                Color.gray
                            }
                        }
                        .frame(width: 1)
                    }
                }
                
                ForEach(0..<strings.count, id: \.self) { index in
                    let shouldShowFingers = (fingers[index] > 0 && barres.isEmpty) || (!barres.isEmpty && fingers[index] > barres.first!)

                    Group {
                        if shouldShowFingers {
                            Color.black
                                .clipShape(Circle())
                                .padding(min(proxy.size.width, proxy.size.height)*0.02)
                        } else if strings[index] < 0 {
                            Text("x")
                                .font(.system(size: proxy.size.width/8))
                        }
                    }
                    .frame(width: proxy.size.width/5, height: proxy.size.height/5)
                    .offset(calculateOffset(index: index, fretSize: CGSize(width: proxy.size.width/5, height: proxy.size.height/5)))
                
                    Group {
                        if shouldShowFingers {
                            Text("\(fingers[index])")
                                .font(.system(size: proxy.size.width/8))
                        }
                    }
                    .frame(width: proxy.size.width/5, height: proxy.size.height/5)
                    .offset(calculateOffset(index: index, fretSize: CGSize(width: proxy.size.width/5, height: proxy.size.height/5), isNumber: true))
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay(
                Group {
                    if let bar = barres.first {
                        let gridHeight = proxy.size.height/5
                        Color.black
                            .clipShape(Capsule())
                            .frame(width: proxy.size.width*1.2, height: proxy.size.height*0.08)
                            .offset(CGSize(width: 0, height: gridHeight * CGFloat(bar - 3) + CGFloat(bar - 3)))
                            
                    }
                }
            )
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

struct FretView_Previews: PreviewProvider {
    static var previews: some View {
        FretView(fingers: [1, 3, 4, 2, 1, 1],
                 strings: [1, 3, 3, 2, 1, 1],
                 barres: [1])
            .frame(width: 100, height: 200)
    }
}
