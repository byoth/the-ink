//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI

struct CanvasLayerView: View {
    private weak var layer: CanvasLayer?
    private weak var toolPicker: ToolPicker?
    private weak var receiver: CanvasSketchingReceiver?
    @State private var canvasView = InheritedPKCanvasView()
    
    init(layer: CanvasLayer? = nil,
         toolPicker: ToolPicker? = .shared,
         receiver: CanvasSketchingReceiver? = nil) {
        self.layer = layer
        self.toolPicker = toolPicker
        self.receiver = receiver
        if isForeground() {
            setupSketching()
        }
    }
    
    var body: some View {
        CanvasUIView(canvasView: $canvasView, receiver: receiver)
            .onAppear {
                DispatchQueue.main.async {
                    applyDrawing()
                }
            }
    }
    
    private func setupSketching() {
        toolPicker?.connectCanvasView(canvasView)
        receiver?.layer = layer
        canvasView.receiver = receiver
    }
    
    private func applyDrawing() {
        guard let drawing = layer?.getTemplateDrawing().getPkDrawing(canvasSize: canvasView.bounds.size) else {
            return
        }
        layer?.pkDrawing = drawing
        canvasView.setup(drawing: drawing)
    }
    
    private func isForeground() -> Bool {
        receiver != nil
    }
}
