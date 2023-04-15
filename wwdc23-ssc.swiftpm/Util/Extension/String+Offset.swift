//
//  String+Offset.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/15.
//

import Foundation

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
