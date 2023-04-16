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
    private var calculator: SketchingCalculator?
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
        Publishers
            .Merge3(
                toolPicker.objectWillChange,
                resource.objectWillChange,
                taskManager.objectWillChange
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        taskManager.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setupSketchingCalculator()
            }
            .store(in: &cancellables)
    }
    
    private func setupSketchingCalculator() {
        let tolerance = taskManager.getCurrentTask()?.progress?.sketchingTolerance ?? 1
        calculator = SketchingCalculator(tolerance: tolerance)
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
    
    func calculateSketching(canvasView: PKCanvasView) {
        let layers = getCurrentLayers()
        guard let sketchedDrawing = layers.last?.pkDrawing,
              let guidelineDrawing = layers.last(where: { $0.isGuideline() })?.pkDrawing else {
            return
        }
        calculator?.updatePixelsExistence(
            size: canvasView.bounds.size,
            sketchedDrawing: sketchedDrawing,
            guidelineDrawing: guidelineDrawing
        )
    }
    
    func updateResource() {
        guard let calculator = calculator else {
            return
        }
        resource.setAmount(resource.getAmount() - calculator.getJustChangedPixels(), maxAmount: 50000)
    }
    
    func updateProgress() {
        guard let calculator = calculator else {
            return
        }
        progress.setAccuracy(calculator.getAccuracy())
    }
    
    func appendFleeingAnimal(origin: CGPoint) {
        guard isErasing() && taskManager.canBeAnimalFleeing() else {
            return
        }
        let animal = FleeingAnimal(origin: origin)
        fleeingAnimals.append(animal)
        DispatchQueue.main.asyncAfter(deadline: .now() + animal.duration) { [weak self] in
            self?.fleeingAnimals.removeAll { $0 === animal }
        }
    }
    
    func appendFlyingAnimal() {
        let animal = FlyingAnimal()
        flyingAnimals.append(animal)
        DispatchQueue.main.asyncAfter(deadline: .now() + animal.duration) { [weak self] in
            self?.flyingAnimals.removeAll { $0 === animal }
        }
    }
    
    func guideUserToGetResource() {
        // TODO: Toast or Script
    }
    
    func getCurrentLayers() -> [CanvasLayer] {
        taskManager.getCurrentTask()?.layers
            .compactMap { type in
                allLayers.first { $0.type == type }
            } ?? []
    }
    
    func isCanvasBlocked() -> Bool {
        !isSketchable() || (!isErasing() && resource.isEmpty())
    }
    
    private func isSketchable() -> Bool {
        taskManager.getCurrentSection()?.isSketchable == true
    }
    
    private func isErasing() -> Bool {
        toolPicker.getTool() is PKEraserTool
    }
}
