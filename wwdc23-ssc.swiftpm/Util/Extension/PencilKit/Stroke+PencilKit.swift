//
//  Stroke+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension Stroke {
    func getPkStroke() -> PKStroke {
        let ink = ink.getPkInk()
        let controlPoints = points.map { $0.getPkStrokePoint() }
        let path = PKStrokePath(controlPoints: controlPoints, creationDate: .now)
        return PKStroke(ink: ink, path: path)
    }
    
    static func build(pkStroke: PKStroke) -> Self {
        Stroke(
            ink: .build(pkInk: pkStroke.ink),
            points: pkStroke.path
                .getAllPoints()
                .map { .build(pkStrokePoint: $0) }
        )
    }
}

extension PKStroke {
    func getStroke() -> Stroke {
        Stroke(
            ink: .build(pkInk: ink),
            points: path
                .getAllPoints()
                .map { .build(pkStrokePoint: $0) }
        )
    }
}

private extension PKStrokePath {
    func getAllPoints() -> [PKStrokePoint] {
        interpolatedPoints(by: .distance(.greatestFiniteMagnitude)).map { $0 }
    }
}
