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
    @Published private var currentScriptIndex = 0
    @Published var displayingScript: String = ""
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
                self?.setScripts($0)
            }
            .store(in: &cancellables)
    }
    
    private func setScripts(_ scripts: [String]) {
        self.scripts = scripts
        self.displayingScript = ""
        self.currentScriptIndex = 0
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
        displayingScript.append(getCurrentScript()[nextIndex])
    }
    
    func gotoNextScript() {
        guard !taskManager.isCurrentTaskLast() else {
            return
        }
        if isTypingAnimation() {
            displayingScript = getCurrentScript()
        } else if hasNextScript() {
            displayingScript = ""
            currentScriptIndex += 1
        } else if !hasCurrentProgress() {
            taskManager.gotoNextTask()
        }
    }
    
    func getCurrentScript() -> String {
        scripts[safe: currentScriptIndex] ?? ""
    }
    
    func hasNextButton() -> Bool {
        (hasNextScript() || !hasCurrentProgress()) && !taskManager.isCurrentTaskLast()
    }
    
    private func isTypingAnimation() -> Bool {
        displayingScript != getCurrentScript()
    }
    
    private func hasNextScript() -> Bool {
        currentScriptIndex < scripts.count - 1
    }
    
    private func hasCurrentProgress() -> Bool {
        taskManager.getCurrentTask()?.progress != nil
    }
}
