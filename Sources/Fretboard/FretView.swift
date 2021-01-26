//
//  FretView.swift
//  FretView
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

public struct FretView: View {
    public let fingers: [Int]
    public let strings: [Int]
    public let barres: [Int]
    
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
                                    .padding((proxy.size.width/7)*0.1)
                            } else if strings[index] < 0 {
                                Text("x")
                                    .foregroundColor(.primary)
                                    .font(.system(size: proxy.size.width/10))
                            }
                        }
                        .frame(width: proxy.size.width/7, height: proxy.size.height/7)
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
            let yOffset = gridSize.height * CGFloat(max(position, 0) - 3) + CGFloat(position - 3)
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
