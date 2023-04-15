//
//  BlinkingTriangle.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/15.
//

import SwiftUI

struct BlinkingTriangle: View {
    let sizeLength: CGFloat
    let color: Color
    @State private var isHidden = false
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: sizeLength, y: sizeLength / 2))
            path.addLine(to: CGPoint(x: 0, y: sizeLength))
        }
        .fill(color)
        .opacity(isHidden ? 0 : 0.5)
        .frame(width: sizeLength, height: sizeLength)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                isHidden.toggle()
            }
        }
    }
}
