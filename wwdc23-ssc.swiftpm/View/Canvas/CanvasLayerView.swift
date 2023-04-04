//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI
import PencilKit

struct CanvasLayerView: View {
    private let drawing: Drawing?
    private weak var sketcher: CanvasViewSketcher?
    @State private var canvasView = DecoratedPKCanvasView()
    
    init(drawing: Drawing? = nil,
         sketcher: CanvasViewSketcher? = nil) {
        self.drawing = drawing
        self.sketcher = sketcher
    }
    
    var body: some View {
        CanvasUIView(
            canvasView: $canvasView,
            sketcher: sketcher
        )
        .onAppear {
            applyDrawing(drawing)
            applySketcher()
        }
    }
    
    private func applyDrawing(_ drawing: Drawing?) {
        DispatchQueue.main.async {
            guard let drawing = drawing?.getPkDrawing(canvasSize: canvasView.bounds.size) else {
                return
            }
            self.canvasView.setDrawing(drawing)
        }
    }
    
    private func applySketcher() {
        sketcher?.canvasView = canvasView
        sketcher?.applyToolPicker()
    }
}
