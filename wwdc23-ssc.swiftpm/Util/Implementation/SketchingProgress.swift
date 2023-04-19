//
//  SketchingProgress.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SketchingProgress: ObservableObject, Gaugeable {
    @Published var accuracy: CGFloat
    
    init(accuracy: CGFloat = 0) {
        self.accuracy = accuracy
    }
    
    func getRate() -> CGFloat {
        accuracy.isNormal ? min(max(accuracy, 0), 1) : 0
    }
}
