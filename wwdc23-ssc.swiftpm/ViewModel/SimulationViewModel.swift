//
//  SimulationViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SimulationViewModel: ObservableObject {
    let taskManager = TaskManager()
    let allLayers = getLayers(types: CanvasLayerType.allCases)
    let resource = SketchingResource()
    let progress = SketchingProgress()
    
    private static func getLayers(types: [CanvasLayerType]) -> [CanvasLayer] {
        types.map { CanvasLayer(type: $0) }
    }
}
