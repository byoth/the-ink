//
//  CanvasLayerType.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Foundation

enum CanvasLayerType: String {
    case background
    case factoryGuideline
    case foreground
    
    var templateDrawing: Drawing {
        switch self {
        case .background:
            return .background
        case .factoryGuideline:
            return .factoryGuideline
        case .foreground:
            return .foreground
        }
    }
}
