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
    private var sketchedPixelsExistence: [Bool] = []
    private var lastSketchedPixelsExistence: [Bool] = []
    private var guidelinePixelsExistence: [Bool] = []
    private var originalSimilarity: CGFloat? = nil
    
    init(tolerance: CGFloat) {
        self.tolerance = tolerance
    }
    
    func updatePixelsExistence(size: CGSize, sketchedDrawing: PKDrawing, guidelineDrawing: PKDrawing) {
        let rect = CGRect(origin: .zero, size: size)
        let sketchImage = sketchedDrawing.image(from: rect, scale: 1)
        lastSketchedPixelsExistence = sketchedPixelsExistence
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
    
    func getAccuracy() -> CGFloat {
        guard let originalSimilarity = originalSimilarity,
              originalSimilarity < 1 else {
            return 0
        }
        let accuracy = (getSimilarity() - originalSimilarity) / (1 - originalSimilarity)
        return accuracy.isNormal ? min(max(accuracy * tolerance, 0), 1) : 0
    }
    
    private func isFirstComparing() -> Bool {
        originalSimilarity == nil
    }
    
    private func getSimilarity() -> CGFloat {
        sketchedPixelsExistence.getSimilarity(guidelinePixelsExistence)
    }
}
