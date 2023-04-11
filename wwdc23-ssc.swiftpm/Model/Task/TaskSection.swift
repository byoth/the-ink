//
//  TaskSection.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct TaskSection {
    let title: String
    let isSketchable: Bool
    var tasks: [Task]
    
    init(title: String,
         isSketchable: Bool = true,
         tasks: [Task]) {
        self.title = title
        self.isSketchable = isSketchable
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
