//
//  CanvasSketchingReceiver.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasSketchingReceiver: NSObject, TouchEventReceivable, CanvasViewDelegate {
    weak var viewModel: CanvasViewModel?
    weak var layer: CanvasLayer?
    
    func begin(point: CGPoint) {
    }
    
    func move(point: CGPoint) {
        if Int.random(in: 0 ..< 60) == 0 {
            viewModel?.appendFleeingAnimal(origin: point)
        }
    }
    
    func end(point: CGPoint) {
    }
    
    func canvasViewLayersDidChange(size: CGSize) {
        updateSketching(size: size)
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        layer?.pkDrawing = canvasView.drawing
        updateSketching(size: canvasView.bounds.size)
    }
    
    private func updateSketching(size: CGSize) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel?.calculateSketching(size: size)
            self.viewModel?.updateResource()
            self.viewModel?.updateProgress()
        }
    }
}
