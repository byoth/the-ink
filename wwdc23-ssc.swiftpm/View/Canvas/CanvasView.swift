//
//  CanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject private var viewModel: CanvasViewModel
    weak var receiver: CanvasSketchingReceiver?
    
    init(allLayers: [CanvasLayer],
         resource: SketchingResource,
         progress: SketchingProgress,
         taskManager: TaskManager,
         receiver: CanvasSketchingReceiver) {
        self.viewModel = CanvasViewModel(
            allLayers: allLayers,
            resource: resource,
            progress: progress,
            taskManager: taskManager
        )
        self.receiver = receiver
        receiver.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    backgroundView()
                    layersView(layers: viewModel.getCurrentLayers())
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
    
    private func backgroundView() -> some View {
        Image("background")
            .resizable()
            .scaledToFit()
    }
    
    private func layersView(layers: [CanvasLayer]) -> some View {
        ForEach(Array(zip(layers.indices, layers)), id: \.1) { index, layer in
            CanvasLayerView(
                layer: layer,
                receiver: index == layers.count - 1 ? receiver : nil
            )
        }
        .transition(.opacity.animation(.easeOut(duration: 0.5)))
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
        let allLayers = [CanvasLayer]()
        let resource = SketchingResource()
        let progress = SketchingProgress()
        let taskManager = TaskManager()
        let receiver = CanvasSketchingReceiver()
        return CanvasView(
            allLayers: allLayers,
            resource: resource,
            progress: progress,
            taskManager: taskManager,
            receiver: receiver
        )
    }
}
