//
//  CanvasLayerType.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Foundation

enum CanvasLayerType: String {
    case mountain
    case factoryGuideline
    case trees
    
    var templateDrawing: Drawing {
        switch self {
        case .mountain:
            return .mountain
        case .factoryGuideline:
            return .factoryGuideline
        case .trees:
            return .trees
        }
    }
}
