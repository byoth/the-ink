//
//  Task.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct Task {
    let title: String
    let isSkippable: Bool
    let gauge: TaskGauge?
    
    init(title: String,
         isSkippable: Bool = false,
         gauge: TaskGauge? = nil) {
        self.title = title
        self.isSkippable = isSkippable
        self.gauge = gauge
    }
}

extension Task: Identifiable, Hashable {
    var id: String {
        title
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
