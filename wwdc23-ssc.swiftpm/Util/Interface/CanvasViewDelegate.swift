//
//  CanvasViewDelegate.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/17.
//

import PencilKit

protocol CanvasViewDelegate: PKCanvasViewDelegate {
    func canvasViewLayersDidChange(size: CGSize)
}
