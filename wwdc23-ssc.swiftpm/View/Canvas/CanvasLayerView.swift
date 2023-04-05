//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI

struct CanvasLayerView: View {
    private let drawing: Drawing?
    private weak var toolPicker: ToolPicker?
    private weak var receiver: CanvasViewSketchingReceiver?
    @State private var canvasView = InheritedPKCanvasView()
    
    init(drawing: Drawing? = nil,
         toolPicker: ToolPicker? = .shared,
         receiver: CanvasViewSketchingReceiver? = nil) {
        self.drawing = drawing
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
                    setupDrawing()
                }
            }
    }
    
    private func setupDrawing() {
        guard let drawing = drawing?.getPkDrawing(canvasSize: canvasView.bounds.size) else {
            return
        }
        canvasView.setup(drawing: drawing)
    }
    
    private func setupSketching() {
        toolPicker?.connectCanvasView(canvasView)
        canvasView.receiver = receiver
    }
    
    private func isForeground() -> Bool {
        receiver != nil
    }
}
