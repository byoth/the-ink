//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject var resource: DrawingResource
    @State private var sketcher = CanvasViewSketcher()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.white
                .cornerRadius(24)
                .shadow(radius: 16, y: 8)
            CanvasLayerView(drawing: .background)
            CanvasLayerView(drawing: .foreground, sketcher: sketcher)
            ResourceGaugeView(resource: resource)
        }
        .aspectRatio(1 / 1, contentMode: .fit)
        .onAppear {
            sketcher.resource = resource
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        let resource = DrawingResource()
        return CanvasView(resource: resource)
    }
}
