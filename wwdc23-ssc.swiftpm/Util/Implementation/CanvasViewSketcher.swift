//
//  CanvasViewDelegate.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewSketcher: NSObject, Sketchable, PKCanvasViewDelegate {
    weak var canvasView: DecoratedPKCanvasView!
    weak var resource: DrawingResource!
    private let toolPicker = PKToolPicker()
    
    func applyToolPicker() {
        toolPicker.selectedTool = PKEraserTool(.vector)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func begin(point: CGPoint) {
    }
    
    func move(point: CGPoint) {
    }
    
    func end(point: CGPoint) {
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateResource()
        printDrawing()
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
    }
    
    private func updateResource() {
        let initialPointsCount = canvasView.getInitialPointCount()
        let currentPointsCount = canvasView.drawing.getPointsCount()
        resource.setAmount(initialPointsCount - currentPointsCount, maxAmount: initialPointsCount)
    }
    
    private func printDrawing() {
        let drawing = Drawing.build(pkDrawing: canvasView.drawing, canvasSize: canvasView.bounds.size)
        let pointsCount = canvasView.drawing.getPointsCount()
        print("@LOG drawing \(pointsCount) \(drawing.getRawValue()) \(drawing.strokes.count) \(pointsCount)")
    }
    
    private func isErasing() -> Bool {
        toolPicker.selectedTool is PKEraserTool
    }
}
