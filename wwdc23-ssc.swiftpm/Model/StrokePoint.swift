//
//  StrokePoint.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import Foundation

struct StrokePoint {
    let relativeLocation: CGPoint
    let timeOffset: TimeInterval
    let relativeSize: CGSize
    let opacity: CGFloat
    let force: CGFloat
    let azimuth: CGFloat
    let altitude: CGFloat
}

extension StrokePoint {
    func getRawValue() -> String {
        let components = [relativeLocation.x, relativeLocation.y, timeOffset, relativeSize.width, relativeSize.height, opacity, force, azimuth, altitude]
            .map { String($0) }
            .joined(separator: "P")
        return components
    }
    
    static func build(rawValue: String) -> Self {
        let components = rawValue
            .split(separator: "P")
            .map { Double($0) ?? 0 }
        return StrokePoint(
            relativeLocation: .init(x: components[0], y: components[1]),
            timeOffset: components[2],
            relativeSize: .init(width: components[3], height: components[4]),
            opacity: components[5],
            force: components[6],
            azimuth: components[7],
            altitude: components[8]
        )
    }
}
