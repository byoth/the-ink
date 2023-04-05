//
//  ColorData.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import UIKit

struct ColorData {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    func getUiColor() -> UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func build(uiColor: UIColor) -> Self {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ColorData(
            red: red.decimalRounded(),
            green: green.decimalRounded(),
            blue: blue.decimalRounded(),
            alpha: alpha.decimalRounded()
        )
    }
}

extension ColorData: CompactCodable {
    func getRawValue() -> String {
        let components = [red, green, blue, alpha]
        return components
            .map { "\($0)" }
            .joined(separator: "C")
    }
    
    static func build(rawValue: String) -> Self {
        let components = rawValue
            .split(separator: "C")
            .map { CGFloat(Double(String($0)) ?? 0) }
        return ColorData(
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}

extension ColorData {
    static let black = ColorData(red: 0, green: 0, blue: 0, alpha: 1)
    static let red = ColorData(red: 1, green: 0, blue: 0, alpha: 1)
}
