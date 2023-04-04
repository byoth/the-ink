//
//  CanvasUIView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI
import PencilKit

struct CanvasUIView: UIViewRepresentable {
    typealias UIViewType = DecoratedPKCanvasView
    
    @Binding var canvasView: UIViewType
    let sketcher: CanvasViewSketcher?
    
    func makeUIView(context: Context) -> UIViewType {
        canvasView.delegate = sketcher
        canvasView.sketcher = sketcher
        canvasView.backgroundColor = .clear
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
