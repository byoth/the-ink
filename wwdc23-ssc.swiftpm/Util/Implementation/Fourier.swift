//
//  FourierSeries.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import Foundation

final class Fourier: ObservableObject, Fourierable, Sketchable {
    // 푸리에 변환에 필요한 기본 설정
    private let numberOfTerms = 10 // 푸리에 급수의 항 수
    private let amplitudeThreshold = 0.1 // 크기가 이 값 이하인 항은 무시함
    @Published private var pencilPoints: [CGPoint] = []
    @Published private var digitizedPoints: [CGPoint] = []
    @Published private var series: [CGPoint] = []
    
    func begin(point: CGPoint) {
        pencilPoints = []
        move(point: point)
    }
    
    func move(point: CGPoint) {
        pencilPoints.append(point)
    }
    
    func end(point: CGPoint) {
        // 푸리에 급수 계산을 수행합니다.
        digitizedPoints = digitize(pencilPoints: pencilPoints)
        series = calculate(digitizedPoints: digitizedPoints, numberOfTerms: numberOfTerms, amplitudeThreshold: amplitudeThreshold)
    }
    
    func getDigitizedPoints() -> [CGPoint] {
        digitizedPoints
    }
    
    func getSeries() -> [CGPoint] {
        series
    }
    
    // 애플 펜슬로 그린 선을 디지털 좌표로 변환하는 함수
    private func digitize(pencilPoints: [CGPoint]) -> [CGPoint] {
        var digitizedPoints = [CGPoint]()
        for point in pencilPoints {
            let digitizedPoint = CGPoint(x: Int(point.x), y: Int(point.y))
            digitizedPoints.append(digitizedPoint)
        }
        return digitizedPoints
    }
    
    // 푸리에 급수 계산 함수
    private func calculate(digitizedPoints: [CGPoint], numberOfTerms: Int, amplitudeThreshold: Double) -> [CGPoint] {
        var series = [CGPoint]()
        let count = digitizedPoints.count
        for i in 0..<count {
            var re = 0.0
            var im = 0.0
            for j in 0..<count {
                let theta = Double(j * i) * Double.pi * 2.0 / Double(count)
                let point = digitizedPoints[j]
                re += Double(point.x) * cos(theta) + Double(point.y) * sin(theta)
                im += Double(point.y) * cos(theta) - Double(point.x) * sin(theta)
            }
            re /= Double(count)
            im /= Double(count)
            let amplitude = sqrt(re * re + im * im)
            if amplitude > amplitudeThreshold {
                let phase = atan2(im, re)
                let frequency = Double(i)
                let point = CGPoint(x: frequency.decimalRounded(), y: phase.decimalRounded())
                series.append(point)
            }
        }
        return series
    }
}
