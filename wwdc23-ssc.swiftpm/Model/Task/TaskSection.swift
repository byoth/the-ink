//
//  TaskSection.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

class TaskSection {
    let title: String
    let tasks: [Task]
    
    init(title: String,
         tasks: [Task]) {
        self.title = title
        self.tasks = tasks
    }
}

extension TaskSection: Identifiable, Hashable {
    var id: String {
        title
    }
    
    static func == (lhs: TaskSection, rhs: TaskSection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
