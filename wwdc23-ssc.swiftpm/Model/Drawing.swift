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
    func getRawValue() -> String {
        strokes
            .map { $0.getRawValue() }
            .joined(separator: "s")
    }
    
    static func build(rawValue: String) -> Self {
        let components = rawValue
            .split(separator: "s")
            .map { String($0) }
        return Drawing(strokes: components.map { .build(rawValue: $0) })
    }
}
