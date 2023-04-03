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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
