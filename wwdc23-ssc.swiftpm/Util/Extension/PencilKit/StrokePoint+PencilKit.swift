//
//  StrokePoint+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension StrokePoint {
    func getPkStrokePoint() -> PKStrokePoint {
        PKStrokePoint(
            location: location,
            timeOffset: timeOffset,
            size: size,
            opacity: opacity,
            force: force,
            azimuth: azimuth,
            altitude: altitude
        )
    }
    
    static func build(pkStrokePoint: PKStrokePoint) -> Self {
        StrokePoint(
            location: CGPoint(
                x: pkStrokePoint.location.x.decimalRounded(),
                y: pkStrokePoint.location.y.decimalRounded()
            ),
            timeOffset: pkStrokePoint.timeOffset.decimalRounded(),
            size: CGSize(
                width: pkStrokePoint.size.width.decimalRounded(),
                height: pkStrokePoint.size.height.decimalRounded()
            ),
            opacity: pkStrokePoint.opacity.decimalRounded(),
            force: pkStrokePoint.force.decimalRounded(),
            azimuth: pkStrokePoint.azimuth.decimalRounded(),
            altitude: pkStrokePoint.altitude.decimalRounded()
        )
    }
}
