//
//  UIImage+Accuracy.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/11.
//

import UIKit

extension UIImage {
    func getAccuracy(to templateImage: UIImage, mercyFactor: CGFloat = 1.5, opaqueAlphaStandard: CGFloat = 0.1) -> CGFloat {
        guard size == templateImage.size else {
            fatalError("Images must have the same size.")
        }
        
        let width = Int(size.width)
        let height = Int(size.height)
        let totalPixelsCount = width * height
        
        guard let cgImage = cgImage,
              let templateCgImage = templateImage.cgImage else {
            fatalError("Could not get CGImage from UIImage.")
        }
        
        guard let imageData = cgImage.dataProvider?.data,
              let templateImageData = templateCgImage.dataProvider?.data,
              let data = CFDataGetBytePtr(imageData),
              let templateData = CFDataGetBytePtr(templateImageData) else {
            return 0
        }
        
        var pixelsCount = 0
        var templatePixelsCount = 0
        var matchingPixelsCount = 0
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let pixelIndex = (y * width) + x
                let pixelInfo = data + (pixelIndex * 4)
                let templatePixelInfo = templateData + (pixelIndex * 4)
                let alpha = CGFloat(pixelInfo[3]) / 255
                let templateAlpha = CGFloat(templatePixelInfo[3]) / 255
                let isOpaque = alpha >= opaqueAlphaStandard
                let isTemplateOpaque = templateAlpha >= opaqueAlphaStandard
                
                if isOpaque {
                    pixelsCount += 1
                }
                
                if isTemplateOpaque {
                    templatePixelsCount += 1
                }
                
                if isOpaque && isTemplateOpaque {
                    matchingPixelsCount += 1
                }
            }
        }
        
        let matchingRate = CGFloat(matchingPixelsCount) / CGFloat(pixelsCount)
        let opaqueRate = CGFloat(pixelsCount) / CGFloat(totalPixelsCount)
        let templateOpaqueRate = CGFloat(templatePixelsCount) / CGFloat(totalPixelsCount)
        let penaltyRate = min((opaqueRate * mercyFactor) / templateOpaqueRate, 1)
        let accuracy = matchingRate * penaltyRate
        
        return accuracy
    }
}
