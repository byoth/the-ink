//
//  Drawing.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import Foundation

struct Drawing {
    let strokes: [Stroke]
}

extension Drawing {
    func getCode() -> String {
        let strokesCode = strokes
            .map { $0.getCode() }
            .joined(separator: ",\n")
        return """
        Drawing(
            strokes: [
                \(strokesCode)
            ]
        )
        """
    }
}

extension Drawing {
    static let sample = Drawing(
        strokes: [
            Stroke(
                ink: Ink(
                    inkType: .pen,
                    color: ColorData(
                        red: 0.0,
                        green: 0.0,
                        blue: 0.0,
                        alpha: 1.0
                    )
                ),
                points: [
                    StrokePoint(
                        location: CGPoint(x: 255.341, y: 504.152),
                        timeOffset: 0.0,
                        size: CGSize(width: 2.631, height: 2.631),
                        opacity: 1.0,
                        force: 0.322,
                        azimuth: 0.609,
                        altitude: 0.766
                    ),
                    StrokePoint(
                        location: CGPoint(x: 995.128, y: 151.983),
                        timeOffset: 0.308,
                        size: CGSize(width: 2.255, height: 2.255),
                        opacity: 1.0,
                        force: 0.016,
                        azimuth: 1.271,
                        altitude: 0.79
                    )
                ]
            ),
            Stroke(
                ink: Ink(
                    inkType: .marker,
                    color: ColorData(
                        red: 0.0,
                        green: 0.0,
                        blue: 0.0,
                        alpha: 1.0
                    )
                ),
                points: [
                    StrokePoint(
                        location: CGPoint(x: 327.038, y: 599.983),
                        timeOffset: 0.0,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.625,
                        force: 0.464,
                        azimuth: 0.22,
                        altitude: 0.79
                    ),
                    StrokePoint(
                        location: CGPoint(x: 874.528, y: 75.734),
                        timeOffset: 0.296,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.303,
                        force: 0.003,
                        azimuth: 0.863,
                        altitude: 0.813
                    )
                ]
            ),
            Stroke(
                ink: Ink(
                    inkType: .pencil,
                    color: ColorData(
                        red: 0.0,
                        green: 0.0,
                        blue: 0.0,
                        alpha: 0.5
                    )
                ),
                points: [
                    StrokePoint(
                        location: CGPoint(x: 463.555, y: 581.139),
                        timeOffset: 0.0,
                        size: CGSize(width: 1.2, height: 1.2),
                        opacity: 0.198,
                        force: 0.323,
                        azimuth: 0.065,
                        altitude: 0.84
                    ),
                    StrokePoint(
                        location: CGPoint(x: 703.135, y: 79.087),
                        timeOffset: 0.266,
                        size: CGSize(width: 1.2, height: 1.2),
                        opacity: 0.208,
                        force: 0.341,
                        azimuth: 0.699,
                        altitude: 0.84
                    )
                ]
            ),
            Stroke(
                ink: Ink(
                    inkType: .marker,
                    color: ColorData(
                        red: 0.08235294117647059,
                        green: 0.49411764705882355,
                        blue: 0.984313725490196,
                        alpha: 1.0
                    )
                ),
                points: [
                    StrokePoint(
                        location: CGPoint(x: 423.619, y: 391.579),
                        timeOffset: 0.0,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.474,
                        force: 0.248,
                        azimuth: 0.589,
                        altitude: 0.893
                    ),
                    StrokePoint(
                        location: CGPoint(x: 528.915, y: 517.527),
                        timeOffset: 0.204,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.304,
                        force: 0.005,
                        azimuth: 0.408,
                        altitude: 0.968
                    )
                ]
            ),
            Stroke(
                ink: Ink(
                    inkType: .marker,
                    color: ColorData(
                        red: 0.9882352941176471,
                        green: 0.19215686274509805,
                        blue: 0.25882352941176473,
                        alpha: 1.0
                    )
                ),
                points: [
                    StrokePoint(
                        location: CGPoint(x: 632.103, y: 177.821),
                        timeOffset: 0.0,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.455,
                        force: 0.221,
                        azimuth: 0.937,
                        altitude: 0.851
                    ),
                    StrokePoint(
                        location: CGPoint(x: 788.894, y: 336.601),
                        timeOffset: 0.212,
                        size: CGSize(width: 13.75, height: 13.75),
                        opacity: 0.325,
                        force: 0.035,
                        azimuth: 0.937,
                        altitude: 0.969
                    )
                ]
            )
        ]
    )
}
