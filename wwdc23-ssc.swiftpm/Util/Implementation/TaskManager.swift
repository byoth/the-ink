//
//  TaskManager.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/10.
//

import Foundation

final class TaskManager: ObservableObject {
    let sections: [TaskSection]
    @Published var currentIndexes = (section: 0, task: 0) {
        didSet {
            guard currentIndexes != oldValue else { return }
            currentProgressRate = 0
            isCurrentTaskCompleted = false
            currentModal = nil
            if !hasNextTask() {
                showEndingEffect()
            }
        }
    }
    @Published var currentProgressRate = CGFloat(0)
    @Published var isCurrentTaskCompleted = false
    @Published var currentModal: TaskModal?
    
    init(sections: [TaskSection] = [.Introduction, .GetResources, .MakeProducts, .TurnEverythingBack]) {
        self.sections = sections
    }
    
    // MARK: - Behavior
    
    func gotoNextTask() {
        guard hasNextTask() else {
            return
        }
        if currentIndexes.task < (sections[safe: currentIndexes.section]?.tasks ?? []).count - 1 {
            currentIndexes.task += 1
        } else if currentIndexes.section < sections.count {
            currentIndexes.section += 1
            currentIndexes.task = 0
        }
        if getCurrentTask()?.isSkippable() == true {
            gotoNextTask()
        }
    }
    
    func showModal(_ modal: TaskModal) {
        currentModal = modal
    }
    
    func completeCurrentTask() {
        isCurrentTaskCompleted = true
        AudioPlayer.shared.play("complete")
    }
    
    private func showEndingEffect() {
        AudioPlayer.shared.play("peaceful")
    }
    
    // MARK: - Public Getter
    
    func hasNextTask() -> Bool {
        !isLast(task: getCurrentTask())
    }
    
    func canAnimalBeFleeing() -> Bool {
        getCurrentSection()?.canAnimalBeFleeing == true
    }
    
    func isCurrentProgressCompleted() -> Bool {
        currentProgressRate >= 1
    }
    
    func hasCurrentModal() -> Bool {
        currentModal != nil
    }
    
    func isHidden(section: TaskSection) -> Bool {
        getSectionIndex(section: section) > currentIndexes.section
    }
    
    func isActive(section: TaskSection, task: Task) -> Bool {
        getSectionIndex(section: section) == currentIndexes.section && getTaskIndex(task: task) == currentIndexes.task
    }
    
    func isCompleted(section: TaskSection) -> Bool {
        getSectionIndex(section: section) < currentIndexes.section
    }
    
    func isCompleted(task: Task) -> Bool {
        getTaskIndex(task: task) < currentIndexes.task
    }
    
    func isLast(task: Task?) -> Bool {
        task == sections.last?.tasks.last
    }
    
    func getCurrentSection() -> TaskSection? {
        sections[safe: currentIndexes.section]
    }
    
    func getCurrentTask() -> Task? {
        getCurrentSection()?.tasks[safe: currentIndexes.task]
    }
    
    func getAvailableModal() -> TaskModal? {
        guard let task = getCurrentTask() else {
            return nil
        }
        switch task {
        case .FillInkGauge:
            return .metaphor
        case .MakeProducts:
            return .productsAreMade
        case .RemoveFactory:
            return .natureCanBeRestored
        default:
            return nil
        }
    }
    
    // MARK: - Private Getter
    
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
