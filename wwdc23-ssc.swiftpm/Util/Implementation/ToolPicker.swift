//
//  ToolPicker.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import PencilKit

final class ToolPicker: NSObject, ObservableObject {
    static let shared = ToolPicker()
    
    private let toolPicker = PKToolPicker()
    private var lastObservers = [PKToolPickerObserver]()
    
    private override init() {
        super.init()
        toolPicker.selectedTool = PKEraserTool(.vector)
    }
    
    func connectCanvasView(_ canvasView: PKCanvasView) {
        removeLastObservers()
        toolPicker.addObserver(self)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
    }
    
    private func removeLastObservers() {
        lastObservers.forEach { toolPicker.removeObserver($0) }
    }
    
    func getTool() -> PKTool {
        toolPicker.selectedTool
    }
}

extension ToolPicker: PKToolPickerObserver {
    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        objectWillChange.send()
    }
}
