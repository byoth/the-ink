//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    let drawing: Drawing?
    let isBackground: Bool
    @State private var canvasView: DecoratedPKCanvasView
    
    init(drawing: Drawing? = nil,
         isBackground: Bool = false,
         canvasView: DecoratedPKCanvasView = .init()) {
        self.drawing = drawing
        self.isBackground = isBackground
        self.canvasView = canvasView
    }
    
    var body: some View {
        CanvasUIView(
            canvasView: $canvasView,
            canvasViewDelegate: isBackground ? nil : CanvasViewDelegate(),
            sketcher: isBackground ? nil : CanvasSketcher(canvasView: canvasView)
        )
        .onAppear {
            applyToolPickerIfNeeded()
            applyDrawing(drawing)
        }
    }
    
    private func applyToolPickerIfNeeded() {
        guard !isBackground else {
            return
        }
        canvasView.applyToolPicker()
    }
    
    private func applyDrawing(_ drawing: Drawing?) {
        guard let drawing = drawing else {
            return
        }
        DispatchQueue.main.async {
            self.canvasView.drawing = drawing.getPkDrawing(canvasSize: self.canvasView.bounds.size)
        }
    }
}
