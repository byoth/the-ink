//
//  StrokePoint+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension StrokePoint {
    func getPkStrokePoint(canvasSize: CGSize) -> PKStrokePoint {
        PKStrokePoint(
            location: CGPoint(
                x: relativeLocation.x * canvasSize.width,
                y: relativeLocation.y * canvasSize.height
            ),
            timeOffset: timeOffset,
            size: CGSize(
                width: relativeSize.width * canvasSize.width,
                height: relativeSize.height * canvasSize.height
            ),
            opacity: opacity,
            force: force,
            azimuth: azimuth,
            altitude: altitude
        )
    }
    
    static func build(pkStrokePoint: PKStrokePoint, canvasSize: CGSize) -> Self {
        StrokePoint(
            relativeLocation: CGPoint(
                x: (pkStrokePoint.location.x / canvasSize.width).decimalRounded(),
                y: (pkStrokePoint.location.y / canvasSize.height).decimalRounded()
            ),
            timeOffset: pkStrokePoint.timeOffset.decimalRounded(),
            relativeSize: CGSize(
                width: (pkStrokePoint.size.width / canvasSize.width).decimalRounded(),
                height: (pkStrokePoint.size.height / canvasSize.height).decimalRounded()
            ),
            opacity: pkStrokePoint.opacity.decimalRounded(),
            force: pkStrokePoint.force.decimalRounded(),
            azimuth: pkStrokePoint.azimuth.decimalRounded(),
            altitude: pkStrokePoint.altitude.decimalRounded()
        )
    }
}
