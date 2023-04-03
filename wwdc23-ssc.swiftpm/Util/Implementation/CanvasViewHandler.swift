//
//  CanvasViewHandler.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasViewHandler: NSObject, PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("@LOG drawing \(canvasView)")
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("@LOG rendering \(canvasView)")
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("@LOG beginUsingTool \(canvasView)")
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("@LOG endUsingTool \(canvasView)")
    }
}
