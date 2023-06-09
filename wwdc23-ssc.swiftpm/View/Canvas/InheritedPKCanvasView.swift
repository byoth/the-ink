//
//  InheritedPKCanvasView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

final class InheritedPKCanvasView: PKCanvasView {
    override var undoManager: UndoManager? {
        nil
    }
    weak var receiver: TouchEventReceivable?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = getPoint(by: touches)
        receiver?.begin(point: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let point = getPoint(by: touches)
        receiver?.move(point: point)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let point = getPoint(by: touches)
        receiver?.end(point: point)
    }
    
    private func getPoint(by touches: Set<UITouch>) -> CGPoint {
        let touch = touches.first!
        let point = touch.location(in: self)
        return point
    }
}
