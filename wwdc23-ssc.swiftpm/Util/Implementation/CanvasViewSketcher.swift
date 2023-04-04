//
//  CanvasViewDelegate.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewSketcher: NSObject, Sketchable, PKCanvasViewDelegate {
    var canvasView: DecoratedPKCanvasView!
    var resource: DrawingResource!
    private let toolPicker = PKToolPicker()
    
    func applyToolPicker() {
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func begin(point: CGPoint) {
        print("@LOG begin \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
    
    func move(point: CGPoint) {
        if isErasing() {
            resource.increaseAmount()
        } else {
            resource.decreaseAmount()
        }
        print("@LOG move \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
    
    func end(point: CGPoint) {
        print("@LOG end \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
    
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
    
    private func isErasing() -> Bool {
        toolPicker.selectedTool is PKEraserTool
    }
}
