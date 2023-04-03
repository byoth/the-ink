//
//  Drawing+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension Drawing {
    func getPkDrawing() -> PKDrawing {
        PKDrawing(strokes: strokes.map { $0.getPkStroke() })
    }
    
    static func build(pkDrawing: PKDrawing) -> Self {
        Drawing(strokes: pkDrawing.strokes.map { .build(pkStroke: $0) })
    }
}

extension PKDrawing {
    func getDrawing() -> Drawing {
        Drawing(strokes: strokes.map { .build(pkStroke: $0) })
    }
    
    static func build(strokes: [Stroke]) -> Self {
        PKDrawing(strokes: strokes.map { $0.getPkStroke() })
    }
}
