//
//  CanvasSketchingReceiver.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasSketchingReceiver: NSObject, TouchEventReceivable, PKCanvasViewDelegate {
    let viewModel: CanvasViewModel
    weak var layer: CanvasLayer?
    
    init(viewModel: CanvasViewModel) {
        self.viewModel = viewModel
    }
    
    func begin(point: CGPoint) {
    }
    
    func move(point: CGPoint) {
        if Int.random(in: 0 ..< 30) == 0 {
            viewModel.appendFleeingAnimal(origin: point)
        }
    }
    
    func end(point: CGPoint) {
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateViewModel(canvasView: canvasView)
        layer?.pkDrawing = canvasView.drawing
    }
    
    private func updateViewModel(canvasView: PKCanvasView) {
        guard let canvasView = canvasView as? InheritedPKCanvasView else {
            return
        }
        DispatchQueue.main.async {
            self.viewModel.updateResource(canvasView: canvasView)
            self.viewModel.updateProgress(canvasView: canvasView)
        }
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
