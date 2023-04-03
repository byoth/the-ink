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
