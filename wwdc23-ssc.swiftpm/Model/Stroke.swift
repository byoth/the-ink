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

extension Stroke {
    func getCode() -> String {
        let pointsCode = points
            .map { $0.getCode() }
            .joined(separator: ",\n")
        return """
        Stroke(
            ink: Ink(
                inkType: .\(ink.inkType.rawValue.split(separator: ".").last ?? "pen"),
                color: \(ink.color.getCode())
            ),
            points: [
                \(pointsCode)
            ]
        )
        """
    }
}
