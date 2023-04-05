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
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Color.white
                CanvasLayerView(drawing: .background)
                CanvasLayerView(drawing: .foreground, receiver: receiver)
                if viewModel.isCanvasBlocked() {
                    blockingView()
                }
            }
            .cornerRadius(24)
            .shadow(radius: 16, y: 8)
            ResourceGaugeView(resource: viewModel.resource)
        }
        .aspectRatio(1 / 1, contentMode: .fit)
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
