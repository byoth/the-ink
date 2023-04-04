//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @State private var canvasView = DecoratedPKCanvasView()
    
    var body: some View {
        CanvasUIView(canvasView: $canvasView)
            .aspectRatio(1 / 1, contentMode: .fit)
            .shadow(radius: 16, y: 8)
    }
}
