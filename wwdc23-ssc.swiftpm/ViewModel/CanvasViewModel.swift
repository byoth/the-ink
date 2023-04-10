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
    @Published var animals: [FleeingAnimal] = []
    let toolPicker: ToolPicker
    let resource: SketchingResource
    let progress: SketchingProgress
    let taskManager: TaskManager
    private var cancellables = Set<AnyCancellable>()
    
    init(layerTypes: [CanvasLayerType] = [.background, .factoryGuideline, .foreground],
         toolPicker: ToolPicker = .shared,
         resource: SketchingResource,
         progress: SketchingProgress,
         taskManager: TaskManager) {
        self.layers = layerTypes.map { CanvasLayer(type: $0) }
        self.toolPicker = toolPicker
        self.resource = resource
        self.progress = progress
        self.taskManager = taskManager
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
        resource.setAmount(
            initialPointsCount - currentPointsCount,
            maxAmount: Int(Double(initialPointsCount) * 0.9)
        )
    }
    
    func updateProgress(canvasView: PKCanvasView) {
        guard let pkDrawing1 = layers[safe: layers.count - 2]?.pkDrawing,
              let pkDrawing2 = layers.last?.pkDrawing else {
            return
        }
        let size = canvasView.bounds.size
        DispatchQueue.global(qos: .userInteractive).async {
            let drawing1 = Drawing.build(pkDrawing: pkDrawing1, canvasSize: size)
            let drawing2 = Drawing.build(pkDrawing: pkDrawing2, canvasSize: size)
            let comparer = DrawingComparer(drawing1: drawing1, drawing2: drawing2, size: size)
            let accuracy = comparer.getAccuracy()
            DispatchQueue.main.async {
                self.progress.setAccuracy(accuracy * 1.1)
            }
        }
    }
    
    func appendFleeingAnimal(origin: CGPoint) {
        guard isErasing() && taskManager.canBeAnimalFleeing() else {
            return
        }
        let animal = FleeingAnimal(origin: origin)
        animals.append(animal)
        DispatchQueue.main.asyncAfter(deadline: .now() + animal.duration) {
            self.animals.removeAll { $0 === animal }
        }
    }
    
    func guideUserToGetResource() {
        // TODO: Toast or Script
    }
    
    func isCanvasBlocked() -> Bool {
        !isErasing() && resource.isEmpty()
    }
    
    private func isErasing() -> Bool {
        toolPicker.getTool() is PKEraserTool
    }
}
