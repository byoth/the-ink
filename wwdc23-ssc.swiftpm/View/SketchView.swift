//
//  SketchView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import SwiftUI
import UIKit

struct SketchView: UIViewRepresentable {
    typealias UIViewType = SketchUIView
    
    @ObservedObject var fourier: Fourier
    
    func makeUIView(context: Context) -> UIViewType {
        let view = SketchUIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.sketcher = fourier
    }
}

class SketchUIView: UIView {
    var sketcher: Sketchable?
    private let path = UIBezierPath()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let point = touch.location(in: self)
        sketcher?.begin(point: point)
        path.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        let point = touch.location(in: self)
        sketcher?.move(point: point)
        path.addLine(to: point)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sketcher?.end(point: .zero)
        if let fourier = sketcher as? Fourier {
            print(fourier.getDigitizedPoints())
            print(fourier.getSeries())
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.stroke()
    }
}
