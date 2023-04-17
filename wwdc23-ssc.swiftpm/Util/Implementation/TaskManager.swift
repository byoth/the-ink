//
//  TaskManager.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/10.
//

import Foundation

final class TaskManager: ObservableObject {
    let sections: [TaskSection]
    @Published private var isWaiting = false
    @Published private var currentSectionIndex = 0
    @Published private var currentTaskIndex = 0
    
    init(sections: [TaskSection] = [.Introduction, .GetResources, .MakeProducts, .TurnEverythingBack]) {
        self.sections = sections
    }
    
    func gotoNextTask() {
        let currentSectionTasks = sections[safe: currentSectionIndex]?.tasks ?? []
        if currentTaskIndex < currentSectionTasks.count - 1 {
            currentTaskIndex += 1
        } else if currentSectionIndex < sections.count {
            currentSectionIndex += 1
            currentTaskIndex = 0
        }
        if getCurrentTask()?.isSkippable() == true {
            gotoNextTask()
        }
    }
    
    func waitForNextTask(completion: @escaping () -> Void) {
        isWaiting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isWaiting = false
            completion()
        }
    }
    
    func isHidden(section: TaskSection) -> Bool {
        getSectionIndex(section: section) > currentSectionIndex
    }
    
    func isActive(section: TaskSection, task: Task) -> Bool {
        getSectionIndex(section: section) == currentSectionIndex && getTaskIndex(task: task) == currentTaskIndex
    }
    
    func isCompleted(section: TaskSection) -> Bool {
        getSectionIndex(section: section) < currentSectionIndex
    }
    
    func isCompleted(task: Task) -> Bool {
        getTaskIndex(task: task) < currentTaskIndex
    }
    
    func getSections() -> [TaskSection] {
        sections
    }
    
    func getCurrentSection() -> TaskSection? {
        sections[safe: currentSectionIndex]
    }
    
    func getCurrentTask() -> Task? {
        getCurrentSection()?.tasks[safe: currentTaskIndex]
    }
    
    func getCurrentStepHashValue() -> Int {
        currentSectionIndex * 10 + currentTaskIndex
    }
    
    func canAnimalBeFleeing() -> Bool {
        getCurrentSection()?.canAnimalBeFleeing == true
    }
    
    func isWaitingForNextTask() -> Bool {
        isWaiting
    }
    
    func isCurrentTaskLast() -> Bool {
        guard let task = getCurrentTask() else {
            return false
        }
        return sections.last?.tasks.last == task
    }
    
    private func getSectionIndex(section: TaskSection) -> Int {
        sections
            .enumerated()
            .first { $0.element == section }?
            .offset ?? -1
    }
    
    private func getTaskIndex(task: Task) -> Int {
        getCurrentSection()?.tasks
            .enumerated()
            .first { $0.element == task }?
            .offset ?? -1
    }
}
