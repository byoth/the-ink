//
//  UIImage+Accuracy.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/11.
//

import UIKit

extension UIImage {
    func getAccuracy(to guidelineImage: UIImage, mercyFactor: CGFloat = 1.5, opaqueAlphaStandard: CGFloat = 0.1) -> CGFloat {
        guard size == guidelineImage.size else {
            fatalError("Images must have the same size.")
        }
        
        let width = Int(size.width)
        let height = Int(size.height)
        let totalPixelsCount = width * height
        
        guard let cgImage = cgImage,
              let guidelineCgImage = guidelineImage.cgImage else {
            fatalError("Could not get CGImage from UIImage.")
        }
        
        guard let imageData = cgImage.dataProvider?.data,
              let guidelineImageData = guidelineCgImage.dataProvider?.data,
              let data = CFDataGetBytePtr(imageData),
              let guidelineData = CFDataGetBytePtr(guidelineImageData) else {
            return 0
        }
        
        var pixelsCount = 0
        var guidelinePixelsCount = 0
        var matchingPixelsCount = 0
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let pixelIndex = (y * width) + x
                let pixelInfo = data + (pixelIndex * 4)
                let guidelinePixelInfo = guidelineData + (pixelIndex * 4)
                let alpha = CGFloat(pixelInfo[3]) / 255
                let guidelineAlpha = CGFloat(guidelinePixelInfo[3]) / 255
                let isOpaque = alpha >= opaqueAlphaStandard
                let isTemplateOpaque = guidelineAlpha >= opaqueAlphaStandard
                
                if isOpaque {
                    pixelsCount += 1
                }
                
                if isTemplateOpaque {
                    guidelinePixelsCount += 1
                }
                
                if isOpaque && isTemplateOpaque {
                    matchingPixelsCount += 1
                }
            }
        }
        
        let matchingRate = CGFloat(matchingPixelsCount) / CGFloat(pixelsCount)
        let opaqueRate = CGFloat(pixelsCount) / CGFloat(totalPixelsCount)
        let guidelineOpaqueRate = CGFloat(guidelinePixelsCount) / CGFloat(totalPixelsCount)
        let penaltyRate = min((opaqueRate * mercyFactor) / guidelineOpaqueRate, 1)
        let accuracy = matchingRate * penaltyRate
        
        return accuracy
    }
}
