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
    @Published private var currentProgressRate = CGFloat(0)
    @Published var isEndingModalNeeded = false
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.taskManager = taskManager
        self.resource = resource
        self.progress = progress
        self.sections = taskManager.getSections()
        subscribeObjects()
    }
    
    private func subscribeObjects() {
        subscribeTaskManager()
        subscribeObjectForGauge(object: resource)
        subscribeObjectForGauge(object: progress)
    }
    
    private func subscribeTaskManager() {
        taskManager.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { _ in self.taskManager.getSections() }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.sections = $0
                self?.currentProgressRate = 0
            }
            .store(in: &cancellables)
        
        taskManager.objectWillChange
            .map { self.isEnding() }
            .filter { $0 }
            .first()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isEndingModalNeeded = true
            }
            .store(in: &cancellables)
    }
    
    private func subscribeObjectForGauge<O: ObservableObject & Gaugeable>(object: O) {
        object.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { _ in object.getPercentage() }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateGauge(object: object)
            }
            .store(in: &cancellables)
    }
    
    private func updateGauge(object: Gaugeable) {
        guard let progress = taskManager.getCurrentTask()?.progress,
              progress.gaugeType == type(of: object) else {
            return
        }
        DispatchQueue.main.async {
            self.currentProgressRate = object.getRate()
        }
        if object.isFull() {
            taskManager.waitForNextTask { [weak self] in
                self?.taskManager.gotoNextTask()
            }
        }
    }
    
    func isCompleted(section: TaskSection, task: Task) -> Bool {
        let isSectionCompleted = taskManager.isCompleted(section: section)
        let isTaskCompleted = (!task.isSkippable() && taskManager.isCompleted(task: task))
        let isProgressCompleted = taskManager.getCurrentTask() == task && currentProgressRate >= 1
        return isSectionCompleted || isTaskCompleted || isProgressCompleted
    }
    
    func getSections() -> [TaskSection] {
        taskManager.getSections()
            .filter { $0.isShownInList }
    }
    
    func getCurrentProgressRate() -> CGFloat {
        currentProgressRate
    }
    
    private func isEnding() -> Bool {
        taskManager.getCurrentTask() == .FillInkGauge && currentProgressRate >= 1
    }
}
