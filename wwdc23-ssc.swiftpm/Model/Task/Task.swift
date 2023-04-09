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
    
    func isCompletable() -> Bool {
        gauge != nil
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
