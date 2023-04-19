//
//  Ink.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

struct Ink {
    let inkType: PKInk.InkType
    let color: ColorData
    
    init(inkType: PKInk.InkType = .pen,
         color: ColorData = .black) {
        self.inkType = inkType
        self.color = color
    }
}

extension Ink {
    func getRawValue() -> String {
        let components = [inkType.rawValue, color.getRawValue()]
        return components
            .map { String($0) }
            .joined(separator: "I")
    }
    
    static func build(rawValue: String) -> Ink {
        let components = rawValue
            .split(separator: "I")
            .map { String($0) }
        return Ink(
            inkType: .init(rawValue: components[0]) ?? .pen,
            color: .build(rawValue: components[1])
        )
    }
}
