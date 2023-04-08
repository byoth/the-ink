//
//  Task.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

class Task {
    let title: String
    let gauge: TaskGauge?
    
    init(title: String,
         gauge: TaskGauge? = nil) {
        self.title = title
        self.gauge = gauge
    }
}

extension Task: Identifiable, Hashable {
    var id: String {
        title
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}