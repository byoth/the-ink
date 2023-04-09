//
//  SimulationViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import Foundation

final class SimulationViewModel: ObservableObject {
    let resource = SketchingResource()
    let progress = SketchingProgress()
    let taskSections: [TaskSection] = [.GetResources, .BuildFactory, .MakeProducts]
}
