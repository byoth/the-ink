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
    @Published var displayingScript = ""
    @Published private var scripts: [String]
    @Published private var currentDisplayingScriptIndex = 0
    private var cancellables = Set<AnyCancellable>()
    
    init(taskManager: TaskManager) {
        self.taskManager = taskManager
        self.scripts = taskManager.getCurrentTask()?.scripts ?? []
        subscribeTaskScripts()
        applyTypingAnimation()
    }
    
    // MARK: - Behavior
    
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
            .map { self.taskManager.isCurrentTaskCompleted }
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
            self?.typeNextLetterInScript()
        }
    }
    
    private func typeNextLetterInScript() {
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
        } else if hasNextScript() {
            displayingScript = ""
            currentDisplayingScriptIndex += 1
        } else if taskManager.isCurrentTaskCompleted || !hasProgress() {
            if let modal = taskManager.getAvailableModal() {
                taskManager.showModal(modal)
            } else {
                taskManager.gotoNextTask()
            }
        }
    }
    
    // MARK: - Public Getter
    
    func getCurrentScript() -> String {
        if !taskManager.isCurrentTaskCompleted {
            return scripts[safe: currentDisplayingScriptIndex] ?? ""
        } else {
            return "Well done."
        }
    }
    
    func getPage() -> String {
        if !taskManager.isCurrentTaskCompleted {
            return "\(currentDisplayingScriptIndex + 1) / \(scripts.count)"
        } else {
            return ""
        }
    }
    
    func hasNextButton() -> Bool {
        guard taskManager.hasNextTask() else {
            return hasNextScript()
        }
        return hasNextScript() || !hasProgress() || taskManager.isCurrentTaskCompleted
    }
    
    // MARK: - Private Getter
    
    private func isTypingAnimation() -> Bool {
        displayingScript != getCurrentScript()
    }
    
    private func hasNextScript() -> Bool {
        currentDisplayingScriptIndex < scripts.count - 1
    }
    
    private func hasProgress() -> Bool {
        taskManager.getCurrentTask()?.progress != nil
    }
}
