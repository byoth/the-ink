//
//  TaskProgress.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct TaskProgress {
    let title: String
    let gaugeType: Gaugeable.Type
    let sketchingTolerance: CGFloat
    let startingBackgroundRGB: RGB
    let endingBackgroundRGB: RGB
    
    init(title: String,
         gaugeType: Gaugeable.Type,
         sketchingTolerance: CGFloat,
         startingBackgroundRGB: RGB,
         endingBackgroundRGB: RGB) {
        self.title = title
        self.gaugeType = gaugeType
        self.sketchingTolerance = sketchingTolerance
        self.startingBackgroundRGB = startingBackgroundRGB
        self.endingBackgroundRGB = endingBackgroundRGB
    }
}
