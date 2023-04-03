//
//  Ink+PencilKit.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/03.
//

import PencilKit

extension Ink {
    func getPkInk() -> PKInk {
        PKInk(inkType, color: color.getUiColor())
    }
    
    static func build(pkInk: PKInk) -> Self {
        Ink(
            inkType: pkInk.inkType,
            color: .build(uiColor: pkInk.color)
        )
    }
}
