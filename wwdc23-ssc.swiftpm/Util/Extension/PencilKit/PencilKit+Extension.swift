//
//  PencilKit+Extension.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import PencilKit

extension PKDrawing {
    func getAllPoints() -> [PKStrokePoint] {
        strokes
            .map { $0.getAllPoints() }
            .flatMap { $0 }
    }
}

extension PKStroke {
    func getAllPoints() -> [PKStrokePoint] {
        path.getAllPoints()
    }
}

extension PKStrokePath {
    func getAllPoints() -> [PKStrokePoint] {
        interpolatedPoints(by: .distance(10)).map { $0 }
    }
}
