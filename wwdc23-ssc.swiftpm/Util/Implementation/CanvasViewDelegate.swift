//
//  CanvasViewDelegate.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewDelegate: NSObject, PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let drawing = Drawing.build(pkDrawing: canvasView.drawing, canvasSize: canvasView.bounds.size)
        let points = canvasView.drawing.getAllPoints()
        print("@LOG drawing \(points.count) \(drawing.getRawValue())")
        print("@LOG strokes count \(drawing.strokes.count)")
        print("@LOG points count \(points.count)")
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
