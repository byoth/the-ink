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
    
    func getMatchingRate(size: CGSize, scale: CGFloat = 1) -> CGFloat {
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
        let opaquePixels = countOpaquePixels(in: imageData1)
        let (matchingPixels, unmatchingPixels) = countMatchingAndUnmatchingPixels(in: imageData1, and: imageData2)
        let matchingRate = calculateMatchingRate(matchingPixels: matchingPixels, opaquePixels: opaquePixels)
        let unmatchingRate = calculateUnmatchingRate(unmatchingPixels: unmatchingPixels, opaquePixels: opaquePixels)
        print("@LOG compare \(opaquePixels) \(matchingPixels) \(unmatchingPixels) \(matchingRate) \(unmatchingRate)")
        return max(min(matchingRate / unmatchingRate, 1), 0)
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

    private func countOpaquePixels(in imageData: [UInt8]) -> Int {
        imageData.filter { $0 > 0 }.count / 4
    }

    private func countMatchingAndUnmatchingPixels(in imageData1: [UInt8], and imageData2: [UInt8]) -> (Int, Int) {
        var matchingPixels = 0
        var unmatchingPixels = 0
        
        for (index, pixel1) in imageData1.enumerated() {
            if index % 4 == 3 {
                let isPixel1Opaque = pixel1 > 0
                let pixel2 = imageData2[index]
                let isPixel2Opaque = pixel2 > 0
                
                if isPixel1Opaque && isPixel2Opaque {
                    matchingPixels += 1
                }
                
                if isPixel1Opaque != isPixel2Opaque {
                    unmatchingPixels += 1
                }
            }
        }
        
        return (matchingPixels, unmatchingPixels)
    }

    private func calculateMatchingRate(matchingPixels: Int, opaquePixels: Int) -> CGFloat {
        CGFloat(matchingPixels) / CGFloat(opaquePixels)
    }

    private func calculateUnmatchingRate(unmatchingPixels: Int, opaquePixels: Int) -> CGFloat {
        CGFloat(unmatchingPixels) / CGFloat(opaquePixels)
    }
}
