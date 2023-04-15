//
//  ScriptViewModel.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/15.
//

import Foundation
import Combine

final class ScriptViewModel: ObservableObject {
    let taskManager: TaskManager
    @Published var scripts: [String]
    @Published var currentScriptIndex = 0
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager) {
        self.taskManager = taskManager
        self.scripts = taskManager.getCurrentTask()?.scripts ?? []
        subscribeTaskScripts()
    }
    
    private func subscribeTaskScripts() {
        taskManager.objectWillChange
            .receive(on: DispatchQueue.main)
            .map { self.taskManager.getCurrentTask()?.scripts ?? [] }
            .sink { [weak self] in
                self?.scripts = $0
            }
            .store(in: &cancellables)
    }
    
    func gotoNextScript() {
        if hasNextScript() {
            currentScriptIndex += 1
        } else if canGotoNextTask() {
            taskManager.gotoNextTask()
        }
    }
    
    func getCurrentScript() -> String {
        scripts[safe: currentScriptIndex] ?? ""
    }
    
    func hasNext() -> Bool {
        hasNextScript() || canGotoNextTask()
    }
    
    private func hasNextScript() -> Bool {
        currentScriptIndex < scripts.count - 1
    }
    
    private func canGotoNextTask() -> Bool {
        taskManager.getCurrentTask()?.progress == nil
    }
}
