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
    
    init(layer: CanvasLayer?,
         toolPicker: ToolPicker?,
         receiver: CanvasSketchingReceiver?,
         isSketchable: Bool) {
        self.layer = layer
        self.toolPicker = toolPicker
        self.receiver = receiver
        if isSketchable {
            setupSketching()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            CanvasUIView(canvasView: $canvasView, receiver: receiver)
                .onLongPressGesture {
                    print("@LOG canvas \(canvasView.drawing.getPointsCount()) \(Drawing.build(pkDrawing: canvasView.drawing, canvasSize: geometry.size).getRawValue()) \(canvasView.drawing.getPointsCount())")
                }
                .onAppear {
                    applyDrawing(size: geometry.size)
                }
        }
    }
    
    private func setupSketching() {
        toolPicker?.connectCanvasView(canvasView)
        receiver?.layer = layer
        canvasView.receiver = receiver
    }
    
    private func applyDrawing(size: CGSize) {
        guard let drawing = layer?
            .getTemplateDrawing()
            .getPkDrawing(canvasSize: size) else {
            return
        }
        layer?.pkDrawing = drawing
        DispatchQueue.main.async {
            canvasView.drawing = drawing
        }
    }
}
