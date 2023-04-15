//
//  Task.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct Task {
    let title: String
    let scripts: [String]
    let progress: TaskProgress?
    
    init(title: String,
         scripts: [String] = [],
         progress: TaskProgress? = nil) {
        self.title = title
        self.scripts = scripts
        self.progress = progress
    }
    
    func isSkippable() -> Bool {
        scripts.isEmpty && progress == nil
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
