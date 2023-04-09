//
//  Gaugeable.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/09.
//

import Foundation

protocol Gaugeable {
    func getRate() -> CGFloat
}

extension Gaugeable {
    func getPercentage() -> Int {
        Int(getRate() * 100)
    }
    
    func isFull() -> Bool {
        getRate() >= 1
    }
    
    func isEmpty() -> Bool {
        getRate() <= 0
    }
}
