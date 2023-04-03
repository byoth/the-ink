//
//  DecoratedPKCanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class DecoratedPKCanvasView: PKCanvasView {
    var sketcher: Sketchable?
    private var toolPicker: PKToolPicker?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = getPoint(by: touches)
        sketcher?.begin(point: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let point = getPoint(by: touches)
        sketcher?.move(point: point)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let point = getPoint(by: touches)
        sketcher?.end(point: point)
    }
    
    func setToolPicker() {
        toolPicker = PKToolPicker()
        toolPicker?.addObserver(self)
        toolPicker?.setVisible(true, forFirstResponder: self)
        becomeFirstResponder()
    }
    
    private func getPoint(by touches: Set<UITouch>) -> CGPoint {
        let touch = touches.first!
        let point = touch.location(in: self)
        return point
    }
}
