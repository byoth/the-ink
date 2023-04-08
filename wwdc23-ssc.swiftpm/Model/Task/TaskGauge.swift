//
//  TaskGauge.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

class TaskGauge {
    let title: String
    var amount: Int
    var maxAmount: Int
    
    init(title: String,
         amount: Int,
         maxAmount: Int) {
        self.title = title
        self.amount = amount
        self.maxAmount = maxAmount
    }
    
    func getPercentage() -> CGFloat {
        .random(in: 0 ... 1) // CGFloat(amount) / CGFloat(maxAmount)
    }
}
