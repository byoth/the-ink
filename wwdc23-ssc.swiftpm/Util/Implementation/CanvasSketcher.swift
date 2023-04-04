//
//  CanvasSketcher.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class CanvasSketcher: Sketchable {
    let canvasView: DecoratedPKCanvasView
    
    init(canvasView: DecoratedPKCanvasView) {
        self.canvasView = canvasView
    }
    
    func begin(point: CGPoint) {
        print("@LOG begin \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
    
    func move(point: CGPoint) {
        print("@LOG move \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
    
    func end(point: CGPoint) {
        print("@LOG end \(canvasView.getStrokesCount()) \(canvasView.getStrokePointsCount())")
    }
}
