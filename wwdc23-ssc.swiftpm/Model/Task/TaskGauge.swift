//
//  TaskGauge.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct TaskGauge {
    let title: String
    let sourceType: Gaugeable.Type
    let startingBackgroundRGB: RGB
    let endingBackgroundRGB: RGB
    
    init(title: String,
         sourceType: Gaugeable.Type,
         startingBackgroundRGB: RGB,
         endingBackgroundRGB: RGB) {
        self.title = title
        self.sourceType = sourceType
        self.startingBackgroundRGB = startingBackgroundRGB
        self.endingBackgroundRGB = endingBackgroundRGB
    }
}
