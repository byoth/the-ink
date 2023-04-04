//
//  Stroke+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension Stroke {
    func getPkStroke(canvasSize: CGSize) -> PKStroke {
        let ink = ink.getPkInk()
        let controlPoints = points.map { $0.getPkStrokePoint(canvasSize: canvasSize) }
        let path = PKStrokePath(controlPoints: controlPoints, creationDate: .now)
        return PKStroke(ink: ink, path: path)
    }
    
    static func build(pkStroke: PKStroke, canvasSize: CGSize) -> Self {
        Stroke(
            ink: .build(pkInk: pkStroke.ink),
            points: pkStroke.path
                .getAllPoints()
                .map { .build(pkStrokePoint: $0, canvasSize: canvasSize) }
        )
    }
}

private extension PKStrokePath {
    func getAllPoints() -> [PKStrokePoint] {
        interpolatedPoints(by: .distance(10)).map { $0 }
    }
}
