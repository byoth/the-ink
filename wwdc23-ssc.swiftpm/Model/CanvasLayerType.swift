//
//  CanvasLayerType.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Foundation

enum CanvasLayerType: String, CaseIterable {
    case constructionSiteGuideline
    case factoryGuideline
    case pollutionGuideline
    case forFactory
    case forPollution
    
    func getTemplateDrawing() -> Drawing {
        switch self {
        case .constructionSiteGuideline:
            return .constructionSiteGuideline
        case .factoryGuideline:
            return .factoryGuideline
        case .pollutionGuideline:
            return .pollutionGuideline
        case .forFactory:
            return .nature
        case .forPollution:
            return .empty
        }
    }
    
    func isGuideline() -> Bool {
        switch self {
        case .constructionSiteGuideline, .factoryGuideline, .pollutionGuideline:
            return true
        default:
            return false
        }
    }
}
