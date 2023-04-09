//
//  Collection+Safe.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/09.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
