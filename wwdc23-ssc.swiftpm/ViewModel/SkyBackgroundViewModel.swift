//
//  SkyBackgroundViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/10.
//

import Foundation
import Combine

final class SkyBackgroundViewModel: ObservableObject {
    let taskManager: TaskManager
    let resource: SketchingResource
    let progress: SketchingProgress
    @Published var rgb: RGB?
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.taskManager = taskManager
        self.resource = resource
        self.progress = progress
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        subscribeObjectForGauge(object: resource)
        subscribeObjectForGauge(object: progress)
    }
    
    private func subscribeObjectForGauge<O: ObservableObject & Gaugeable>(object: O) {
        object.objectWillChange
            .receive(on: DispatchQueue.main)
            .map { _ in object.getPercentage() }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateRGB(object: object)
            }
            .store(in: &cancellables)
    }
    
    private func updateRGB(object: Gaugeable) {
        guard let gauge = taskManager.getCurrentTask()?.gauge,
              gauge.sourceType == type(of: object) else {
            return
        }
        let startingRGB = gauge.startingBackgroundRGB
        let endingRGB = gauge.endingBackgroundRGB
        let factor = object.getRate()
        rgb = (
            getCalculatedValue(starting: startingRGB.0, ending: endingRGB.0, factor: factor),
            getCalculatedValue(starting: startingRGB.1, ending: endingRGB.1, factor: factor),
            getCalculatedValue(starting: startingRGB.2, ending: endingRGB.2, factor: factor)
        )
    }
    
    func getRGB() -> RGB? {
        rgb
    }
    
    private func getCalculatedValue(starting: Int, ending: Int, factor: CGFloat) -> Int {
        starting + Int(CGFloat(ending - starting) * factor)
    }
}
