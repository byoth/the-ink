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
    
    init(title: String,
         sourceType: Gaugeable.Type) {
        self.title = title
        self.sourceType = sourceType
    }
}
