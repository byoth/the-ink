//
//  UIView+Layer.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import UIKit

extension UIView {
    func applyRoundedCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
}
