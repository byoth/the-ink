//
//  FlyingAnimalView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/14.
//

import SwiftUI

struct FlyingAnimalView: View {
    private static let sizeLength: CGFloat = 40
    let animal: FlyingAnimal
    let canvasSize: CGSize
    @State private var x = CGFloat(0)
    @State private var isFlying = false
    
    var body: some View {
        Group {
            Text(String(animal.character))
                .font(.system(size: Self.sizeLength))
                .frame(width: Self.sizeLength, height: Self.sizeLength)
                .offset(y: isFlying ? animal.flyingY : 0)
        }
        .transformEffect(CGAffineTransform(translationX: -Self.sizeLength / 2, y: -Self.sizeLength / 2))
        .allowsHitTesting(false)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        .offset(x: x, y: canvasSize.height * animal.relativeY)
        .onAppear {
            withAnimation(.linear(duration: animal.duration)) {
                x = canvasSize.width
            }
            withAnimation(.easeInOut(duration: 1).repeatCount(3)) {
                isFlying.toggle()
            }
        }
    }
}

struct FlyingAnimalView_Previews: PreviewProvider {
    static var previews: some View {
        let animal = FlyingAnimal()
        return FlyingAnimalView(animal: animal, canvasSize: .zero)
    }
}
