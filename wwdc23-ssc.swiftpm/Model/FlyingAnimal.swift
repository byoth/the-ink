//
//  FlyingAnimal.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/14.
//

import Foundation

class FlyingAnimal {
    let relativeY: CGFloat
    let character: Character
    let flyingY: CGFloat
    let duration: TimeInterval
    
    init(relativeY: CGFloat = .random(in: 0.1 ... 0.2),
         character: Character = "🕊️",
         flyingY: CGFloat = CGFloat(Int.random(in: 40 ... 80)),
         duration: TimeInterval = 3) {
        self.relativeY = relativeY
        self.character = character
        self.flyingY = flyingY
        self.duration = duration
    }
}

extension FlyingAnimal: Identifiable, Hashable {
    var id: String {
        "(\(relativeY), \(flyingY))"
    }
    
    static func == (lhs: FlyingAnimal, rhs: FlyingAnimal) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
