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
    @Published var layers: [CanvasLayerType] = []
    @Published var fleeingAnimals: [FleeingAnimal] = []
    @Published var flyingAnimals: [FlyingAnimal] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(allLayers: [CanvasLayer],
         toolPicker: ToolPicker = .shared,
         resource: SketchingResource,
         progress: SketchingProgress,
         taskManager: TaskManager,
         isIntroduction: Bool = false) {
        self.allLayers = allLayers
        self.toolPicker = toolPicker
        self.resource = resource
        self.progress = progress
        self.taskManager = taskManager
        subscribeObjects()
        if isIntroduction {
            showPeacefulEffect()
        }
    }
    
    private func subscribeObjects() {
        toolPicker.objectWillChange
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        taskManager.objectWillChange
            .map { self.taskManager.getCurrentTask()?.layers ?? [] }
            .filter { !$0.isEmpty }
            .sink { [weak self] in
                self?.layers = $0
            }
            .store(in: &cancellables)
    }
    
    private func showPeacefulEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] timer in
                self?.appendFlyingAnimal()
                if self?.flyingAnimals.count == 3 {
                    timer.invalidate()
                }
            }
        }
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
                self.progress.setAccuracy(accuracy * 3)
            }
        }
    }
    
    func appendFleeingAnimal(origin: CGPoint) {
        guard isErasing() && taskManager.canBeAnimalFleeing() else {
            return
        }
        let animal = FleeingAnimal(origin: origin)
        fleeingAnimals.append(animal)
        DispatchQueue.main.asyncAfter(deadline: .now() + animal.duration) {
            self.fleeingAnimals.removeAll { $0 === animal }
        }
    }
    
    func appendFlyingAnimal() {
        let animal = FlyingAnimal()
        flyingAnimals.append(animal)
        DispatchQueue.main.asyncAfter(deadline: .now() + animal.duration) {
            self.flyingAnimals.removeAll { $0 === animal }
        }
    }
    
    func guideUserToGetResource() {
        // TODO: Toast or Script
    }
    
    func getCurrentLayers() -> [CanvasLayer] {
        let layers = taskManager.getCurrentTask()?.layers ?? []
        return allLayers.filter { layers.contains($0.type) }
    }
    
    func isCanvasBlocked() -> Bool {
        !isSketchable() || (!isErasing() && resource.isEmpty())
    }
    
    func isSketchable() -> Bool {
        taskManager.getCurrentSection()?.isSketchable == true
    }
    
    private func isErasing() -> Bool {
        toolPicker.getTool() is PKEraserTool
    }
}
