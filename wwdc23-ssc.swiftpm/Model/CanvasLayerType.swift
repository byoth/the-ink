//
//  CanvasLayerType.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import Foundation

enum CanvasLayerType: String, CaseIterable {
    case background
    case constructionSiteGuideline
    case factoryGuideline
    case foreground
    
    func getTemplateDrawing() -> Drawing {
        switch self {
        case .background:
            return .background
        case .constructionSiteGuideline:
            return .constructionSiteGuideline
        case .factoryGuideline:
            return .factoryGuideline
        case .foreground:
            return .foreground
        }
    }
    
    func isGuideline() -> Bool {
        switch self {
        case .constructionSiteGuideline, .factoryGuideline:
            return true
        default:
            return false
        }
    }
}
