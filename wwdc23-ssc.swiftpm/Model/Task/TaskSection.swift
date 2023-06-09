//
//  TaskSection.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

struct TaskSection {
    let title: String
    let isShownInList: Bool
    let isSketchable: Bool
    let canAnimalBeFleeing: Bool
    var tasks: [Task]
    
    init(title: String,
         isShownInList: Bool = true,
         isSketchable: Bool = true,
         canAnimalBeFleeing: Bool = false,
         tasks: [Task]) {
        self.title = title
        self.isShownInList = isShownInList
        self.isSketchable = isSketchable
        self.canAnimalBeFleeing = canAnimalBeFleeing
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
