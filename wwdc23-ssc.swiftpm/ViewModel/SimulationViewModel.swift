//
//  SimulationViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation
import Combine

final class SimulationViewModel: ObservableObject {
    let taskManager = TaskManager()
    let allLayers = CanvasLayerType.allCases.map { CanvasLayer(type: $0) }
    let resource = SketchingResource()
    let progress = SketchingProgress()
    let receiver = CanvasSketchingReceiver()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeObjects()
    }
    
    // MARK: - Behavior
    
    private func subscribeObjects() {
        subscribeObjectForGauge(object: resource)
        subscribeObjectForGauge(object: progress)
    }
    
    private func subscribeObjectForGauge<O: ObservableObject & Gaugeable>(object: O) {
        object.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { _ in object.getPercentage() }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateGauge(object: object)
            }
            .store(in: &cancellables)
    }
    
    private func updateGauge(object: Gaugeable) {
        guard let progress = taskManager.getCurrentTask()?.progress,
              progress.gaugeType == type(of: object) else {
            return
        }
        let rate = object.getRate()
        taskManager.currentProgressRate = rate
        if object.isFull() {
            taskManager.completeCurrentTask()
        }
    }
}
