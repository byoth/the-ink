//
//  CanvasViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Combine
import PencilKit

final class CanvasViewModel: ObservableObject {
    let toolPicker: ToolPicker
    let resource: SketchingResource
    private var cancellables = Set<AnyCancellable>()
    
    init(toolPicker: ToolPicker = .shared,
         resource: SketchingResource) {
        self.toolPicker = toolPicker
        self.resource = resource
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
