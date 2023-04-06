//
//  DrawingsComparer.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import UIKit

struct DrawingsComparer {
    let drawing1: Drawing
    let drawing2: Drawing
    let size: CGSize
    let scale: CGFloat = 1
    
    func getMatchingRate() -> CGFloat {
        let rect = CGRect(origin: .zero, size: size)
        let image1 = drawing1
            .getPkDrawing(canvasSize: size)
            .image(from: rect, scale: scale)
        let image2 = drawing2
            .getPkDrawing(canvasSize: size)
            .image(from: rect, scale: scale)
        return getMatchingRateOfImagesAsTransparent(image1, image2)
    }
    
    private func getMatchingRateOfImagesAsTransparent(_ image1: UIImage, _ image2: UIImage) -> CGFloat {
        guard let cgImage1 = image1.cgImage,
              let cgImage2 = image2.cgImage else {
            return 0
        }
        let imageData1 = getImageData(from: cgImage1)
        let imageData2 = getImageData(from: cgImage2)
        
        var totalPixels = 0
        var sketchedPixels = 0
        var drawingPixels = 0
        var transparentPixels = 0
        var matchingPixels = 0
        var unmatchingPixels = 0
        
        for (index, pixel1) in imageData1.enumerated() {
            if index % 4 == 3 {
                let pixel2 = imageData2[index]
                let isPixel1Opaque = pixel1 > 0
                let isPixel2Opaque = pixel2 > 0
                
                totalPixels += 1
                
                if isPixel1Opaque {
                    sketchedPixels += 1
                }
                
                if isPixel2Opaque {
                    drawingPixels += 1
                }
                
                if !(isPixel1Opaque || isPixel2Opaque) {
                    transparentPixels += 1
                }
                
                if isPixel1Opaque && isPixel2Opaque {
                    matchingPixels += 1
                }
                
                if isPixel1Opaque != isPixel2Opaque {
                    unmatchingPixels += 1
                }
            }
        }
        
        let matchingRate = CGFloat(matchingPixels) / CGFloat(sketchedPixels) * 1.01
        
        return max(min(matchingRate, 1), 0)
    }

    private func getImageData(from cgImage: CGImage) -> [UInt8] {
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        var imageData = [UInt8](repeating: 0, count: height * bytesPerRow)
        let context = CGContext(data: &imageData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return imageData
    }
}
