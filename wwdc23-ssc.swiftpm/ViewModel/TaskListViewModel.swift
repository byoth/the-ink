//
//  TaskListViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation
import Combine

final class TaskListViewModel: ObservableObject {
    // TODO: Task 관련 모델들을 struct로 바꿔볼까?
    let sections: [TaskSection]
    let progress: SketchingProgress
    @Published private var currentSectionIndex = 1
    @Published private var currentTaskIndex = 1
    @Published private var currentGaugeRate = CGFloat(0)
    private var cancellables = Set<AnyCancellable>()
    
    init(sections: [TaskSection],
         progress: SketchingProgress) {
        self.sections = sections
        self.progress = progress
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        subscribeForProgressToGauge()
    }
    
    private func subscribeForProgressToGauge() {
        progress.objectWillChange
            .receive(on: DispatchQueue.main)
            .map { self.progress.getPercentage() }
            .removeDuplicates()
            .sink { [weak self] in
                self?.updateGauge(amount: $0, maxAmount: 100)
            }
            .store(in: &cancellables)
    }
    
    private func updateGauge(amount: Int, maxAmount: Int) {
        guard let gauge = getCurrentTask()?.gauge else {
            return
        }
        gauge.setAmount(amount, maxAmount: maxAmount)
        currentGaugeRate = gauge.getRate()
    }
    
    func isHidden(section: TaskSection) -> Bool {
        getSectionIndex(section: section) > currentSectionIndex
    }
    
    func isActive(section: TaskSection, task: Task) -> Bool {
        getSectionIndex(section: section) == currentSectionIndex && getTaskIndex(task: task) == currentTaskIndex
    }
    
    func isCompleted(task: Task) -> Bool {
        getTaskIndex(task: task) < currentTaskIndex
    }
    
    func getCurrentGaugeRate() -> CGFloat {
        currentGaugeRate
    }
    
    private func getSectionIndex(section: TaskSection) -> Int {
        sections
            .enumerated()
            .first { $0.element === section }?
            .offset ?? -1
    }
    
    private func getTaskIndex(task: Task) -> Int {
        getCurrentSection()?.tasks
            .enumerated()
            .first { $0.element === task }?
            .offset ?? -1
    }
    
    private func getCurrentSection() -> TaskSection? {
        sections[safe: currentSectionIndex]
    }
    
    private func getCurrentTask() -> Task? {
        getCurrentSection()?.tasks[safe: currentTaskIndex]
    }
}
