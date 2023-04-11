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
    let progress: TaskProgress?
    
    init(title: String,
         isSkippable: Bool = false,
         progress: TaskProgress? = nil) {
        self.title = title
        self.isSkippable = isSkippable
        self.progress = progress
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
