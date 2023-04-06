//
//  CanvasViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Combine
import PencilKit

final class CanvasViewModel: ObservableObject {
    @Published var layers: [CanvasLayer]
    let toolPicker: ToolPicker
    let resource: SketchingResource
    let progress: SketchingProgress
    private var cancellables = Set<AnyCancellable>()
    
    init(layerTypes: [CanvasLayerType] = [.factoryGuideline, .mountain, .trees],
         toolPicker: ToolPicker = .shared,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.layers = layerTypes.map { CanvasLayer(type: $0) }
        self.toolPicker = toolPicker
        self.resource = resource
        self.progress = progress
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        Publishers
            .Merge(toolPicker.objectWillChange, resource.objectWillChange)
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func updateResource(canvasView: InheritedPKCanvasView) {
        let initialPointsCount = canvasView.getInitialPointCount()
        let currentPointsCount = canvasView.drawing.getPointsCount()
        resource.setAmount(initialPointsCount - currentPointsCount, maxAmount: initialPointsCount)
    }
    
    func updateProgress(canvasView: PKCanvasView) {
        guard let pkDrawing1 = layers.first?.pkDrawing,
              let pkDrawing2 = layers.last?.pkDrawing else {
            return
        }
        let size = canvasView.bounds.size
        let drawing1 = Drawing.build(pkDrawing: pkDrawing1, canvasSize: size)
        let drawing2 = Drawing.build(pkDrawing: pkDrawing2, canvasSize: size)
        let comparer = DrawingsComparer(drawing1: drawing1, drawing2: drawing2, size: size)
        progress.setAmount(matchingRate: comparer.getMatchingRate())
    }
    
    func guideUserToGetResource() {
        // TODO: - Toast or Script
    }
    
    func isCanvasBlocked() -> Bool {
        isResourceEmpty() && !(getTool() is PKEraserTool)
    }
    
    private func isResourceEmpty() -> Bool {
        resource.isEmpty()
    }
    
    private func getTool() -> PKTool {
        toolPicker.getTool()
    }
}
