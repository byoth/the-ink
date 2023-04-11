//
//  DrawingComparer.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import UIKit
import PencilKit

struct DrawingComparer {
    let drawing: PKDrawing
    let guidelineDrawing: PKDrawing
    let size: CGSize
    let scale: CGFloat = 1
    
    func getAccuracy() -> CGFloat {
        let rect = CGRect(origin: .zero, size: size)
        let image = drawing.image(from: rect, scale: scale)
        let guidelineImage = guidelineDrawing.image(from: rect, scale: scale)
        return image.getAccuracy(to: guidelineImage)
    }
}
