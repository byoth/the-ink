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
        let drawing = canvasView.drawing.getDrawing()
        print("@LOG drawing \(drawing.getCode())")
        print("@LOG strokes count \(drawing.strokes.count)")
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
