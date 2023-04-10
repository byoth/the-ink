//
//  FleeingAnimalView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/09.
//

import SwiftUI

struct FleeingAnimalView: View {
    private static let sizeLength: CGFloat = 40
    let animal: FleeingAnimal
    @State private var x: CGFloat
    @State private var y: CGFloat
    @State private var isJumping = false
    @State private var opacity = CGFloat(1)
    
    init(animal: FleeingAnimal) {
        self.animal = animal
        x = animal.origin.x
        y = animal.origin.y
    }
    
    var body: some View {
        Group {
            Text(String(animal.character))
                .font(.system(size: Self.sizeLength))
                .frame(width: Self.sizeLength, height: Self.sizeLength)
                .offset(y: isJumping ? -animal.jumpingY : 0)
        }
        .allowsHitTesting(false)
        .rotation3DEffect(.degrees(getXDegrees()), axis: (x: 0, y: 1, z: 0))
        .offset(x: x, y: y)
        .transformEffect(CGAffineTransform(translationX: -Self.sizeLength / 2, y: -Self.sizeLength / 2))
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                x += animal.movingOffset.x
                y += animal.movingOffset.y
                opacity = 0
            }
            withAnimation(.easeInOut(duration: 0.3).repeatCount(4)) {
                isJumping.toggle()
            }
        }
    }
    
    private func getXDegrees() -> CGFloat {
        animal.movingOffset.x > 0 ? 180 : 0
    }
}

struct FleeingAnimalsView_Previews: PreviewProvider {
    static var previews: some View {
        let animal = FleeingAnimal(origin: .zero)
        return FleeingAnimalView(animal: animal)
    }
}
