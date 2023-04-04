//
//  CanvasUIView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI
import PencilKit

struct CanvasUIView: UIViewRepresentable {
    typealias UIViewType = PKCanvasView
    
    @Binding var canvasView: DecoratedPKCanvasView
    private let canvasViewDelegate: PKCanvasViewDelegate = CanvasViewHandler()
    private let sketcher: Sketchable = Sketcher()
    
    func makeUIView(context: Context) -> UIViewType {
        canvasView.delegate = canvasViewDelegate
        canvasView.sketcher = sketcher
        canvasView.setToolPicker()
        canvasView.applyStyle()
        canvasView.becomeFirstResponder()
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            uiView.drawing = Drawing.sample.getPkDrawing(canvasSize: canvasView.bounds.size)
        }
    }
}
