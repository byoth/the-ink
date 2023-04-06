//
//  SketchingProgress.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SketchingProgress: ObservableObject {
    @Published private var matchingRate: CGFloat
    
    init(matchingRate: CGFloat = 0) {
        self.matchingRate = matchingRate
    }
    
    func setAmount(matchingRate: CGFloat) {
        self.matchingRate = matchingRate
    }
    
    func getRate() -> CGFloat {
        matchingRate
    }
    
    func getPercentage() -> Int {
        Int(matchingRate * 100)
    }
}
