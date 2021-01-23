//
//  FretView.swift
//  Fretboard
//
//  Created by Huong Do on 23/01/2021.
//

import SwiftUI

struct FretView: View {
    let fingers = [0, 3, 2, 0, 1, 0]
    let strings = [-1, 3, 2, 0, 1, 0]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: proxy.size.height/5) {
                    ForEach(0...5, id: \.self) { i in
                        Color.black
                            .frame(height: i == 0 ? 3 : 1)
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
                    ZStack {
                        VStack {
                            if strings[index] > 0 {
                                Color.black
                                    .clipShape(Circle())
                                    .padding(4)
                            } else if strings[index] < 0 {
                                Text("x")
                            }
                        }
                        .frame(width: proxy.size.width/5, height: proxy.size.height/5)
                        .offset(calculateFingerOffset(index: index, fretSize: CGSize(width: proxy.size.width/5, height: proxy.size.height/5)))
                        
                        VStack {
                            if fingers[index] > 0 {
                                Text("\(fingers[index])")
                            }
                        }
                        .frame(width: proxy.size.width/5, height: proxy.size.height/5)
                        .offset(calculateNumberOffset(index: index, fretSize: CGSize(width: proxy.size.width/5, height: proxy.size.height/5)))
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        
    }
    
    private func calculateNumberOffset(index: Int, fretSize: CGSize) -> CGSize {
        return CGSize(width: fretSize.width * (CGFloat(index) - 2.5), height: fretSize.width * 3)
    }
    
    private func calculateFingerOffset(index: Int, fretSize: CGSize) -> CGSize {
        let position = strings[index]
        let xOffset = fretSize.width * (CGFloat(index) - 2.5)
        let yOffset = fretSize.height * CGFloat(max(position, 0) - 3)
        return CGSize(width: xOffset, height: yOffset)
    }
}

struct FretView_Previews: PreviewProvider {
    static var previews: some View {
        FretView()
            .frame(width: 200, height: 200)
    }
}
