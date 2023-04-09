//
//  SketchingProgress.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SketchingProgress: ObservableObject {
    @Published private var accuracy: CGFloat
    
    init(accuracy: CGFloat = 0) {
        self.accuracy = accuracy
    }
    
    func setAccuracy(_ accuracy: CGFloat) {
        self.accuracy = accuracy
    }
    
    func getRate() -> CGFloat {
        accuracy
    }
    
    func getPercentage() -> Int {
        Int(accuracy * 100)
    }
}
