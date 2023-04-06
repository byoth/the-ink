//
//  CanvasViewSketchingReceiver.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewSketchingReceiver: NSObject, TouchEventReceivable, PKCanvasViewDelegate {
    weak var viewModel: CanvasViewModel?
    weak var layer: CanvasLayer?
    
    func begin(point: CGPoint) {
    }
    
    func move(point: CGPoint) {
    }
    
    func end(point: CGPoint) {
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if let canvasView = canvasView as? InheritedPKCanvasView {
            DispatchQueue.main.async {
                self.viewModel?.updateResource(canvasView: canvasView)
                self.viewModel?.updateProgress(canvasView: canvasView)
            }
        }
        layer?.pkDrawing = canvasView.drawing
    }
    
    private func printDrawing(canvasView: PKCanvasView) {
        let drawing = Drawing.build(
            pkDrawing: canvasView.drawing,
            canvasSize: canvasView.bounds.size
        )
        let pointsCount = canvasView.drawing.getPointsCount()
        print("@LOG drawing \(pointsCount) \(drawing.getRawValue()) \(drawing.strokes.count) \(pointsCount)")
    }
}
