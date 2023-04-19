//
//  CanvasLayerType.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Foundation

enum CanvasLayerType: String, CaseIterable {
    case nature
    case forFactory
    case forPollution
    case forFreeDrawing
    case factoryGuideline
    case pollutionGuideline
    case emptyGuideline
    
    func getTemplateDrawing() -> Drawing {
        switch self {
        case .nature:
            return .nature
        case .forFactory:
            return .empty
        case .forPollution:
            return .empty
        case .forFreeDrawing:
            return .traces
        case .factoryGuideline:
            return .factoryGuideline
        case .pollutionGuideline:
            return .pollutionGuideline
        case .emptyGuideline:
            return .empty
        }
    }
    
    func isGuideline() -> Bool {
        switch self {
        case .factoryGuideline, .pollutionGuideline, .emptyGuideline:
            return true
        default:
            return false
        }
    }
}
