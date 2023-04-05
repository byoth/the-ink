//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject var viewModel: CanvasViewModel
    @State private var receiver = CanvasViewSketchingReceiver()
    
    init(resource: SketchingResource) {
        viewModel = CanvasViewModel(resource: resource)
        receiver.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    Color.white
                    layersView()
                    if viewModel.isCanvasBlocked() {
                        blockingView()
                    }
                }
                .cornerRadius(24)
                .shadow(radius: 16, y: 8)
                VStack {
                    Button("Compare") {
                        viewModel.compareLayers(size: geometry.size)
                    }
                    ResourceGaugeView(resource: viewModel.resource)
                }
            }
        }
        .aspectRatio(1 / 1, contentMode: .fit)
    }
    
    private func layersView() -> some View {
        ForEach(Array(zip(viewModel.layers.indices, viewModel.layers)), id: \.0) { index, layer in
            CanvasLayerView(
                layer: layer,
                receiver: index == viewModel.layers.count - 1 ? receiver : nil
            )
        }
    }
    
    private func blockingView() -> some View {
        Color.white
            .opacity(0.01)
            .onTapGesture {
                viewModel.guideUserToGetResource()
            }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        let resource = SketchingResource()
        return CanvasView(resource: resource)
    }
}
