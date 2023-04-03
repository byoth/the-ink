//
//  CompactCodable.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/04.
//

import Foundation

protocol CompactCodable {
    func getRawValue() -> String
    static func build(rawValue: String) -> Self
}
