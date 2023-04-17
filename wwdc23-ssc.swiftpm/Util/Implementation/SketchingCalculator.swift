//
//  SketchingCalculator.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import UIKit
import PencilKit

final class SketchingCalculator {
    let tolerance: CGFloat
    private var sketchedPixelsExistence: [Bool] = [] {
        willSet {
            lastSketchedPixelsExistence = sketchedPixelsExistence
        }
    }
    private var guidelinePixelsExistence: [Bool] = []
    private var lastSketchedPixelsExistence: [Bool] = []
    private var originalSimilarity: CGFloat? = nil
    
    init(tolerance: CGFloat) {
        self.tolerance = tolerance
    }
    
    func updatePixelsExistence(size: CGSize, sketchedDrawing: PKDrawing, guidelineDrawing: PKDrawing) {
        guard size != .zero else {
            return
        }
        let rect = CGRect(origin: .zero, size: size)
        let sketchImage = sketchedDrawing.image(from: rect, scale: 1)
        sketchedPixelsExistence = sketchImage.getPixelsExistence()
        if isFirstComparing() {
            let guidelineImage = guidelineDrawing.image(from: rect, scale: 1)
            guidelinePixelsExistence = guidelineImage.getPixelsExistence()
            originalSimilarity = getSimilarity()
        }
    }
    
    func getJustChangedPixels() -> Int {
        guard !lastSketchedPixelsExistence.isEmpty else {
            return 0
        }
        return sketchedPixelsExistence.filter { $0 }.count - lastSketchedPixelsExistence.filter { $0 }.count
    }
    
    func getOriginalSketchedPixels() -> Int {
        Int(CGFloat(sketchedPixelsExistence.filter { $0 }.count) / tolerance)
    }
    
    func getAccuracy() -> CGFloat {
        guard let originalSimilarity = originalSimilarity,
              originalSimilarity < 1 else {
            return 0
        }
        let accuracy = (getSimilarity() - originalSimilarity) / (1 - originalSimilarity)
        return accuracy.isNormal ? accuracy * tolerance : 0
    }
    
    private func isFirstComparing() -> Bool {
        originalSimilarity == nil
    }
    
    private func getSimilarity() -> CGFloat {
        sketchedPixelsExistence.getSimilarity(guidelinePixelsExistence)
    }
}
