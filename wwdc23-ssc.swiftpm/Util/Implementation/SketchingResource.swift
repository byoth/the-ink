//
//  SketchingResource.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import Foundation

final class SketchingResource: ObservableObject {
    @Published private var amount: Int
    private var maxAmount: Int
    
    init(amount: Int = 0,
         maxAmount: Int = 1) {
        self.amount = amount
        self.maxAmount = maxAmount
    }
    
    func setAmount(_ amount: Int, maxAmount: Int? = nil) {
        self.amount = amount
        if let maxAmount = maxAmount {
            self.maxAmount = maxAmount
        }
    }
    
    func getPercentage() -> CGFloat {
        CGFloat(amount) / CGFloat(maxAmount)
    }
    
    func isFull() -> Bool {
        getPercentage() >= 1
    }
    
    func isEmpty() -> Bool {
        getPercentage() <= 0
    }
}
