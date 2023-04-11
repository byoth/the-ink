//
//  CanvasLayer.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/05.
//

import PencilKit

final class CanvasLayer {
    let type: CanvasLayerType
    var pkDrawing: PKDrawing?
    
    init(type: CanvasLayerType,
         pkDrawing: PKDrawing? = nil) {
        self.type = type
        self.pkDrawing = pkDrawing
    }
    
    func getTemplateDrawing() -> Drawing {
        type.templateDrawing
    }
}

extension CanvasLayer: Identifiable, Hashable {
    var id: CanvasLayerType {
        type
    }
    
    static func == (lhs: CanvasLayer, rhs: CanvasLayer) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
