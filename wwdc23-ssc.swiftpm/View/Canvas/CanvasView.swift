//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject private var viewModel: CanvasViewModel
    @State private var receiver: CanvasSketchingReceiver
    
    init(resource: SketchingResource,
         progress: SketchingProgress,
         taskManager: TaskManager) {
        let viewModel = CanvasViewModel(
            resource: resource,
            progress: progress,
            taskManager: taskManager
        )
        self.viewModel = viewModel
        self.receiver = CanvasSketchingReceiver(viewModel: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    Color.white
                    layersView()
                    ForEach(viewModel.animals) { animal in
                        FleeingAnimalView(animal: animal)
                    }
                    if viewModel.isCanvasBlocked() {
                        blockingView()
                    }
                }
                .cornerRadius(24)
                .shadow(radius: 16, y: 8)
                ResourceGaugeView(resource: viewModel.resource)
            }
        }
        .aspectRatio(1 / 1, contentMode: .fit)
    }
    
    private func layersView() -> some View {
        ForEach(Array(zip(viewModel.layers.indices, viewModel.layers)), id: \.1) { index, layer in
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
        let progress = SketchingProgress()
        let taskManager = TaskManager()
        return CanvasView(
            resource: resource,
            progress: progress,
            taskManager: taskManager
        )
    }
}
