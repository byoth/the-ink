//
//  CanvasUIView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI

struct CanvasUIView: UIViewRepresentable {
    typealias UIViewType = InheritedPKCanvasView
    
    @Binding var canvasView: UIViewType
    weak var receiver: CanvasViewSketchingReceiver?
    
    // TODO: init with @Binding
    
    func makeUIView(context: Context) -> UIViewType {
        canvasView.delegate = receiver
        canvasView.receiver = receiver
        canvasView.backgroundColor = .clear
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
