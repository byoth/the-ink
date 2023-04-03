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
}

extension ColorData {
    func getCode() -> String {
        """
        ColorData(
            red: \(red),
            green: \(green),
            blue: \(blue),
            alpha: \(alpha)
        )
        """
    }
    
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

extension ColorData {
    static let black = ColorData(red: 0, green: 0, blue: 0, alpha: 1)
}
