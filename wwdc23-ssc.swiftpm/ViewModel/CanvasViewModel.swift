//
//  CanvasViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Combine
import PencilKit

final class CanvasViewModel: ObservableObject {
    let allLayers: [CanvasLayer]
    let toolPicker: ToolPicker
    let resource: SketchingResource
    let progress: SketchingProgress
    let taskManager: TaskManager
    private var cancellables = Set<AnyCancellable>()
    
    // TODO: class 분리
    @Published var animals: [FleeingAnimal] = []
    
    init(allLayers: [CanvasLayer],
         toolPicker: ToolPicker = .shared,
         resource: SketchingResource,
         progress: SketchingProgress,
         taskManager: TaskManager) {
        self.allLayers = allLayers
        self.toolPicker = toolPicker
        self.resource = resource
        self.progress = progress
        self.taskManager = taskManager
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        Publishers
            .Merge(
                toolPicker.objectWillChange,
                taskManager.objectWillChange
            )
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
        let layers = getCurrentLayers()
        guard let drawing = layers.last?.pkDrawing,
              let guidelineDrawing = layers.last(where: { $0.isGuideline() })?.pkDrawing else {
            return
        }
        let size = canvasView.bounds.size
        DispatchQueue.global(qos: .userInteractive).async {
            let comparer = DrawingComparer(
                drawing: drawing,
                guidelineDrawing: guidelineDrawing,
                size: size
            )
            let accuracy = comparer.getAccuracy()
            DispatchQueue.main.async {
                // TODO: factor 조정
                self.progress.setAccuracy(accuracy * 1.5)
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
    
    func getCurrentLayers() -> [CanvasLayer] {
        let layerTypes = taskManager.getCurrentTask()?.progress?.layerTypes ?? []
        return allLayers
            .filter { layerTypes.contains($0.type) }
    }
    
    func isCanvasBlocked() -> Bool {
        !isErasing() && resource.isEmpty()
    }
    
    private func isErasing() -> Bool {
        toolPicker.getTool() is PKEraserTool
    }
}
