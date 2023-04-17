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
    
    // TRICK: canvasView의 size가 가끔 .zero일 때가 있어서 이전 size를 저장해서 사용
    private var lastSize: CGSize?
    
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
        let size = canvasView.bounds.size
        if size != .zero {
            lastSize = size
        }
        layer?.pkDrawing = canvasView.drawing
        updateSketching(size: lastSize ?? size)
    }
    
    private func updateSketching(size: CGSize) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel?.calculateSketching(size: size)
            self.viewModel?.updateResource()
            self.viewModel?.updateProgress()
        }
    }
}
