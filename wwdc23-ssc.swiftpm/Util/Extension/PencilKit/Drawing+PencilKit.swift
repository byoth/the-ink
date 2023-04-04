//
//  Drawing+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension Drawing {
    func getPkDrawing(canvasSize: CGSize) -> PKDrawing {
        PKDrawing(strokes: strokes.map { $0.getPkStroke(canvasSize: canvasSize) })
    }
    
    static func build(pkDrawing: PKDrawing, canvasSize: CGSize) -> Self {
        Drawing(strokes: pkDrawing.strokes.map { .build(pkStroke: $0, canvasSize: canvasSize) })
    }
}
