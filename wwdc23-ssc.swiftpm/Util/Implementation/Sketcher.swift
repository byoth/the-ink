//
//  Sketcher.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import Foundation

final class Sketcher: Sketchable {
    func begin(point: CGPoint) {
        print("@LOG begin \(point)")
    }
    
    func move(point: CGPoint) {
        print("@LOG move \(point)")
    }
    
    func end(point: CGPoint) {
        print("@LOG end \(point)")
    }
}
