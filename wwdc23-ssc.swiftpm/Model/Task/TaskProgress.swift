//
//  TaskProgress.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct TaskProgress {
    let title: String
    let layerTypes: [CanvasLayerType]
    let gaugeType: Gaugeable.Type
    let startingBackgroundRGB: RGB
    let endingBackgroundRGB: RGB
    
    init(title: String,
         layerTypes: [CanvasLayerType],
         gaugeType: Gaugeable.Type,
         startingBackgroundRGB: RGB,
         endingBackgroundRGB: RGB) {
        self.title = title
        self.layerTypes = layerTypes
        self.gaugeType = gaugeType
        self.startingBackgroundRGB = startingBackgroundRGB
        self.endingBackgroundRGB = endingBackgroundRGB
    }
}
