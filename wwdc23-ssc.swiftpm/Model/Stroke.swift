//
//  Stroke.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import Foundation

struct Stroke {
    let ink: Ink
    let points: [StrokePoint]
}

extension Stroke: CompactCodable {
    func getRawValue() -> String {
        let ink = ink.getRawValue()
        let points = points
            .map { $0.getRawValue() }
            .joined(separator: "p")
        let components = [ink, points]
            .joined(separator: "S")
        return components
    }
    
    static func build(rawValue: String) -> Self {
        let components = rawValue
            .split(separator: "S")
            .map { String($0) }
        return Stroke(
            ink: .build(rawValue: components[0]),
            points: components[1]
                .split(separator: "p")
                .map { String($0) }
                .map { .build(rawValue: $0) }
        )
    }
}
