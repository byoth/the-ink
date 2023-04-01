//
//  Double+CGFloat.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/01.
//

import Foundation

extension Double {
    func cgFloat(decimalPoint: Int) -> CGFloat {
        let factor = pow(Double(10), Double(decimalPoint))
        return (self * factor).rounded() / factor
    }
}
