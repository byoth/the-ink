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
    private weak var receiver: CanvasViewSketchingReceiver?
    @State private var canvasView = InheritedPKCanvasView()
    
    init(layer: CanvasLayer? = nil,
         toolPicker: ToolPicker? = .shared,
         receiver: CanvasViewSketchingReceiver? = nil) {
        self.layer = layer
        self.toolPicker = toolPicker
        self.receiver = receiver
        if isForeground() {
            setupSketching()
        }
    }
    
    var body: some View {
        ZStack {
            CanvasUIView(canvasView: $canvasView, receiver: receiver)
                .onAppear {
                    DispatchQueue.main.async {
                        setupDrawing()
                    }
                }
        }
    }
    
    private func setupDrawing() {
        guard let drawing = layer?.type.templateDrawing.getPkDrawing(canvasSize: canvasView.bounds.size) else {
            return
        }
        layer?.pkDrawing = drawing
        canvasView.setup(drawing: drawing)
    }
    
    private func setupSketching() {
        toolPicker?.connectCanvasView(canvasView)
        receiver?.layer = layer
        canvasView.receiver = receiver
    }
    
    private func isForeground() -> Bool {
        receiver != nil
    }
}
