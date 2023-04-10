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
    @Published private var sections: [TaskSection]
    @Published private var currentGaugeRate = CGFloat(0)
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.taskManager = taskManager
        self.resource = resource
        self.progress = progress
        sections = taskManager.getSections()
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        subscribeTaskManager()
        subscribeObjectForGauge(object: resource)
        subscribeObjectForGauge(object: progress)
    }
    
    private func subscribeTaskManager() {
        taskManager.objectWillChange
            .sink { [weak self] in
                self?.sections = self?.taskManager.getSections() ?? []
                self?.currentGaugeRate = 0
            }
            .store(in: &cancellables)
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
        guard let gauge = taskManager.getCurrentTask()?.gauge,
              gauge.sourceType == type(of: object) else {
            return
        }
        currentGaugeRate = object.getRate()
        if object.isFull() {
            taskManager.gotoNextTask()
        }
    }
    
    func isHidden(section: TaskSection) -> Bool {
        taskManager.isHidden(section: section)
    }
    
    func isActive(section: TaskSection, task: Task) -> Bool {
        taskManager.isActive(section: section, task: task)
    }
    
    func isCompleted(section: TaskSection, task: Task) -> Bool {
        (!task.isSkippable && taskManager.isCompleted(task: task)) || taskManager.isCompleted(section: section)
    }
    
    func getSections() -> [TaskSection] {
        taskManager.getSections()
    }
    
    func getCurrentStepHashValue() -> Int {
        taskManager.getCurrentStepHashValue()
    }
    
    func getCurrentGaugeRate() -> CGFloat {
        currentGaugeRate
    }
}
