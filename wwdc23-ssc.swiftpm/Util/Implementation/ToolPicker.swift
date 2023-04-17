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
    
    override init() {
        super.init()
        toolPicker.selectedTool = PKEraserTool(.bitmap)
        toolPicker.addObserver(self)
    }
    
    func connectCanvasView(_ canvasView: PKCanvasView) {
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
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
