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

extension StrokePoint {
    func getCode() -> String {
        """
        StrokePoint(
            location: CGPoint(x: \(location.x), y: \(location.y)),
            timeOffset: \(timeOffset),
            size: CGSize(width: \(size.width), height: \(size.height)),
            opacity: \(opacity),
            force: \(force),
            azimuth: \(azimuth),
            altitude: \(altitude)
        )
        """
    }
}
