//
//  UIImage+Accuracy.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/11.
//

import UIKit

extension UIImage {
    func getPixelsExistence() -> [Bool] {
        guard let data = cgImage?.dataProvider?.data,
              let dataPtr = CFDataGetBytePtr(data) else {
            return []
        }
        var existence = [Bool]()
        let width = Int(size.width)
        let height = Int(size.height)
        for y in 0 ..< height {
            for x in 0 ..< width {
                let index = (y * width) + x
                let info = dataPtr + (index * 4)
                let alpha = CGFloat(info[3]) / 255
                existence.append(alpha > 0)
            }
        }
        return existence
    }
}
