//
//  SimulationViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SimulationViewModel: ObservableObject {
    let taskManager = TaskManager()
    let allLayers = CanvasLayerType.allCases.map { CanvasLayer(type: $0) }
    let resource = SketchingResource()
    let progress = SketchingProgress()
}
