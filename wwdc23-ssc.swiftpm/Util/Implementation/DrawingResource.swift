//
//  Palette.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import Foundation

final class DrawingResource: ObservableObject {
    private static let maxValue = 100
    
    @Published private var amount: Int
    
    init(amount: Int = 0) {
        self.amount = amount
    }
    
    func increaseAmount() {
        guard amount < Self.maxValue else {
            return
        }
        amount += 1
    }
    
    func decreaseAmount() {
        guard amount > 0 else {
            return
        }
        amount -= 1
    }
    
    func getPercentage() -> CGFloat {
        CGFloat(amount) / CGFloat(Self.maxValue)
    }
    
    func isFull() -> Bool {
        getPercentage() >= 1
    }
    
    func isEmpty() -> Bool {
        getPercentage() <= 0
    }
}
