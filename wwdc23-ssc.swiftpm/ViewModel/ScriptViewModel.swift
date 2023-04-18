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
    @Published private var scripts: [String]
    @Published private var currentDisplayingScriptIndex = 0
    @Published var displayingScript = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager) {
        self.taskManager = taskManager
        self.scripts = taskManager.getCurrentTask()?.scripts ?? []
        subscribeTaskScripts()
        applyTypingAnimation()
    }
    
    private func subscribeTaskScripts() {
        taskManager.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { self.taskManager.getCurrentTask()?.scripts ?? [] }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.scripts = $0
                self?.resetDisplayingScript()
            }
            .store(in: &cancellables)
        
        taskManager.objectWillChange
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.global(qos: .userInteractive))
            .map { self.taskManager.isWaitingForNextTask() }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if $0 {
                    self?.scripts = []
                }
                self?.resetDisplayingScript()
            }
            .store(in: &cancellables)
    }
    
    private func resetDisplayingScript() {
        displayingScript = ""
        currentDisplayingScriptIndex = 0
    }
    
    private func applyTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.typeScript()
        }
    }
    
    private func typeScript() {
        guard isTypingAnimation() else {
            return
        }
        let nextIndex = displayingScript.count
        let script = getCurrentScript()
        if nextIndex < script.count {
            displayingScript.append(script[nextIndex])
        }
    }
    
    func gotoNextScript() {
        if isTypingAnimation() {
            displayingScript = getCurrentScript()
        } else {
            if hasNextScript() {
                displayingScript = ""
                currentDisplayingScriptIndex += 1
            } else if (!isProgressing() || taskManager.isWaitingForNextTask()) && !taskManager.isCurrentTaskLast() {
                taskManager.gotoNextTask()
            }
        }
    }
    
    func getCurrentScript() -> String {
        if !taskManager.isWaitingForNextTask() {
            return scripts[safe: currentDisplayingScriptIndex] ?? ""
        } else {
            return "Well done."
        }
    }
    
    func hasNextButton() -> Bool {
        if !hasNextScript() && taskManager.isCurrentTaskLast() {
            return false
        }
        return (hasNextScript() || !isProgressing()) || taskManager.isWaitingForNextTask()
    }
    
    private func isTypingAnimation() -> Bool {
        displayingScript != getCurrentScript()
    }
    
    private func hasNextScript() -> Bool {
        currentDisplayingScriptIndex < scripts.count - 1
    }
    
    private func isProgressing() -> Bool {
        taskManager.getCurrentTask()?.progress != nil
    }
}
