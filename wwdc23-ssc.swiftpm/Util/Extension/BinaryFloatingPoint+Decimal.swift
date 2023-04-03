//
//  BinaryFloatingPoint+Decimal.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import Foundation

extension BinaryFloatingPoint {
    func decimalRounded(_ decimalPoint: Int = 3) -> Self {
        let factor = Self(pow(Double(10), Double(decimalPoint)))
        return (self * factor).rounded() / factor
    }
}
