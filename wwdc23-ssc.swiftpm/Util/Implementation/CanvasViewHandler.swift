//
//  CanvasViewHandler.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewHandler: NSObject, PKCanvasViewDelegate {
    private var lastDrawing: PKDrawing?
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        lastDrawing = canvasView.drawing
        let drawing = Drawing.build(pkDrawing: canvasView.drawing, canvasSize: canvasView.bounds.size)
        let pointsCount = drawing.strokes
            .map { $0.points }
            .reduce(0) { $0 + $1.count }
        print("@LOG drawing \(pointsCount) \(drawing.getRawValue())")
        print("@LOG strokes count \(drawing.strokes.count)")
        print("@LOG points count \(pointsCount)")
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("@LOG rendering \(canvasView)")
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("@LOG beginUsingTool \(canvasView)")
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("@LOG endUsingTool \(canvasView)")
    }
}
