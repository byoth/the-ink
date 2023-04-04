//
//  Sketchable.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import Foundation

protocol Sketchable: AnyObject {
    func begin(point: CGPoint)
    func move(point: CGPoint)
    func end(point: CGPoint)
}
