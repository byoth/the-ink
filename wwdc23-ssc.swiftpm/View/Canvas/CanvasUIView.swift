//
//  CanvasUIView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI

struct CanvasUIView: UIViewRepresentable {
    @Binding var canvasView: InheritedPKCanvasView
    weak var receiver: CanvasSketchingReceiver?
    
    // TODO: init with @Binding
    
    func makeUIView(context: Context) -> InheritedPKCanvasView {
        canvasView.delegate = receiver
        canvasView.receiver = receiver
        canvasView.backgroundColor = .clear
        return canvasView
    }
    
    func updateUIView(_ uiView: InheritedPKCanvasView, context: Context) {
    }
}
