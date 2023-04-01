//
//  FourierSeriesable.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import Foundation

protocol Fourierable {
    func getDigitizedPoints() -> [CGPoint]
    func getSeries() -> [CGPoint]
}
