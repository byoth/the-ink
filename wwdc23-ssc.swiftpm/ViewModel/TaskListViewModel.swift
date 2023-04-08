//
//  TaskListViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

final class TaskListViewModel: ObservableObject {
    let sections: [TaskSection]
    
    init(sections: [TaskSection] = [.GetResources, .BuildFactory, .MaintainFactory]) {
        self.sections = sections
    }
    
    func isHidden(section: TaskSection) -> Bool {
        .random()
    }
    
    func isCompleted(task: Task) -> Bool {
        .random()
    }
}
