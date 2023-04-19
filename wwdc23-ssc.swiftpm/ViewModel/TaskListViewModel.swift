//
//  TaskListViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation
import Combine

final class TaskListViewModel: ObservableObject {
    let taskManager: TaskManager
    let resource: SketchingResource
    let progress: SketchingProgress
    let sections: [TaskSection]
    @Published var hasCurrentModal = false
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.taskManager = taskManager
        self.resource = resource
        self.progress = progress
        self.sections = taskManager.sections
        subscribeTaskManager()
    }
    
    // MARK: - Behavior
    
    private func subscribeTaskManager() {
        taskManager.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        taskManager.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { self.taskManager.currentModal }
            .removeDuplicates()
            .map { $0 != nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.hasCurrentModal = $0
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Getter
    
    func isCompleted(section: TaskSection, task: Task) -> Bool {
        let isSectionCompleted = taskManager.isCompleted(section: section)
        let isTaskCompleted = (!task.isSkippable() && taskManager.isCompleted(task: task))
        let isProgressCompleted = taskManager.getCurrentTask() == task && taskManager.isCurrentProgressCompleted()
        return isSectionCompleted || isTaskCompleted || isProgressCompleted
    }
    
    func getSections() -> [TaskSection] {
        taskManager.sections
            .filter { $0.isShownInList }
    }
}
