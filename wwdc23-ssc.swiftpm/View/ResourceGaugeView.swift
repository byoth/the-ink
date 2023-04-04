//
//  ResourceGaugeView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import SwiftUI

struct ResourceGaugeView: View {
    private static let lineWidth: CGFloat = 16
    private static let sizeLength: CGFloat = 64
    
    @ObservedObject var resource: DrawingResource
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.white, .gray]),
                        center: .top,
                        startRadius: 0,
                        endRadius: 100
                    )
                )
            Image(systemName: getImageName())
                .font(.title3)
                .onTapGesture {
                    resource.increaseAmount()
                }
            Circle()
                .stroke(
                    RadialGradient(
                        gradient: Gradient(colors: [.gray, .black]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 100
                    ),
                    lineWidth: Self.lineWidth
                )
            Circle()
                .trim(from: 0.0, to: getValue())
                .stroke(.black, style: StrokeStyle(lineWidth: Self.lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90.0))
        }
        .frame(width: Self.sizeLength, height: Self.sizeLength)
        .scaleEffect(x: getScale(), y: getScale())
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: getValue())
    }
    
    private func getValue() -> CGFloat {
        resource.getPercentage()
    }
    
    private func getImageName() -> String {
        resource.isEmpty() ? "paintbrush.pointed" : "paintbrush.pointed.fill"
    }
    
    private func getScale() -> CGFloat {
        resource.isFull() ? 1.1 : 1
    }
}
