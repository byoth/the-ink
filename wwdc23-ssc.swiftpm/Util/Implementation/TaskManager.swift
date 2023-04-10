//
//  TaskManager.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/10.
//

import Foundation

final class TaskManager: ObservableObject {
    @Published private var sections: [TaskSection]
    @Published private var currentSectionIndex = -1
    @Published private var currentTaskIndex = -1
    
    init(sections: [TaskSection] = [.GetResources, .BuildFactory, .MakeProducts]) {
        self.sections = sections
        
        // TODO: needs removing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.gotoNextTask()
        }
    }
    
    func gotoNextTask() {
        let currentSectionTasks = sections[safe: currentSectionIndex]?.tasks ?? []
        if currentTaskIndex < currentSectionTasks.count - 1 {
            currentTaskIndex += 1
        } else if currentSectionIndex < sections.count {
            currentSectionIndex += 1
            currentTaskIndex = 0
        }
        if getCurrentTask()?.isSkippable == true {
            gotoNextTask()
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
    
    func getCurrentStepHashValue() -> Int {
        currentSectionIndex * 10 + currentTaskIndex
    }
    
    func getCurrentTask() -> Task? {
        getCurrentSection()?.tasks[safe: currentTaskIndex]
    }
    
    private func getCurrentSection() -> TaskSection? {
        sections[safe: currentSectionIndex]
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
