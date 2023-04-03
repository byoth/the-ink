//
//  StrokePoint.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import Foundation

struct StrokePoint {
    let location: CGPoint
    let timeOffset: TimeInterval
    let size: CGSize
    let opacity: CGFloat
    let force: CGFloat
    let azimuth: CGFloat
    let altitude: CGFloat
}

extension StrokePoint: CompactCodable {
    func getRawValue() -> String {
        let components = [location.x, location.y, timeOffset, size.width, size.height, opacity, force, azimuth, altitude]
            .map { String($0) }
            .joined(separator: "P")
        return components
    }
    
    static func build(rawValue: String) -> Self {
        let components = rawValue
            .split(separator: "P")
            .map { Double($0) ?? 0 }
        return StrokePoint(
            location: .init(x: components[0], y: components[1]),
            timeOffset: components[2],
            size: .init(width: components[3], height: components[4]),
            opacity: components[5],
            force: components[6],
            azimuth: components[7],
            altitude: components[8]
        )
    }
}
