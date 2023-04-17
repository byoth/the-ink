//
//  SketchingResource.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import Foundation

final class SketchingResource: ObservableObject, Gaugeable {
    @Published private var amount: Int
    @Published private var maxAmount: Int?
    
    init(amount: Int = 0,
         maxAmount: Int? = nil) {
        self.amount = amount
        self.maxAmount = maxAmount
    }
    
    func setAmount(_ amount: Int, maxAmount: Int? = nil) {
        self.amount = amount
        if self.maxAmount == nil {
            self.maxAmount = maxAmount
        }
    }
    
    func getRate() -> CGFloat {
        let rate = CGFloat(amount) / CGFloat(maxAmount ?? 1)
        return rate.isNormal ? min(max(rate, 0), 1) : 0
    }
    
    func getAmount() -> Int {
        amount
    }
}
