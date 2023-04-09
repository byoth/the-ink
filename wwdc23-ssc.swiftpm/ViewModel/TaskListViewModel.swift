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
    let resource: SketchingResource
    let progress: SketchingProgress
    @Published private var currentSectionIndex = 0
    @Published private var currentTaskIndex = 3
    @Published private var currentGaugeRate = CGFloat(0)
    private var cancellables = Set<AnyCancellable>()
    
    init(sections: [TaskSection],
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.sections = sections
        self.resource = resource
        self.progress = progress
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        subscribeObjectForGauge(object: resource)
        subscribeObjectForGauge(object: progress)
    }
    
    private func subscribeObjectForGauge<O: ObservableObject & Gaugeable>(object: O) {
        object.objectWillChange
            .receive(on: DispatchQueue.main)
            .map { _ in object.getPercentage() }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateGauge(object: object)
            }
            .store(in: &cancellables)
    }
    
    private func updateGauge(object: Gaugeable) {
        guard let gauge = getCurrentTask()?.gauge,
              gauge.sourceType == type(of: object) else {
            return
        }
        gauge.setAmount(object.getPercentage(), maxAmount: 100)
        currentGaugeRate = gauge.getRate()
        if gauge.isFull() {
            gotoNextTask()
        }
    }
    
    // TODO: needs improvement
    private func gotoNextTask() {
        currentSectionIndex = 1
        currentTaskIndex = 1
        currentGaugeRate = 0
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
    
    func getCurrentGaugeRate() -> CGFloat {
        currentGaugeRate
    }
    
    func getCurrentStepHashValue() -> Int {
        currentSectionIndex * 10 + currentTaskIndex
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
