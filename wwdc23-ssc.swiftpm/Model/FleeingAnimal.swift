//
//  FleeingAnimal.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/09.
//

import Foundation

class FleeingAnimal {
    let origin: CGPoint
    let character: Character
    let movingOffset: CGPoint
    let jumpingY: CGFloat
    
    init(origin: CGPoint,
         character: Character = Character(["🐿️", "🐇", "🦌"].randomElement()!),
         movingOffset: CGPoint = getRandomMovingOffset(),
         jumpingY: CGFloat = CGFloat(Int.random(in: 20 ... 40))) {
        self.origin = origin
        self.character = character
        self.movingOffset = movingOffset
        self.jumpingY = jumpingY
    }
    
    private static func getRandomMovingOffset() -> CGPoint {
        CGPoint(
            x: CGFloat(Int.random(in: 80 ... 120) * (Bool.random() ? 1 : -1)),
            y: CGFloat(Int.random(in: 40 ... 80))
        )
    }
}

extension FleeingAnimal: Identifiable, Hashable {
    var id: String {
        "(\(origin.x), \(origin.y))"
    }
    
    static func == (lhs: FleeingAnimal, rhs: FleeingAnimal) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
