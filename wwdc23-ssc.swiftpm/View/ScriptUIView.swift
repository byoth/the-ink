//
//  ScriptUIView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/15.
//

import SwiftUI

struct ScriptUIView: UIViewRepresentable {
    let text: String
    let width: CGFloat
    @State private var label = UILabel()
    
    func makeUIView(context: Context) -> UILabel {
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.preferredMaxLayoutWidth = width
        return label
    }
    
    func updateUIView(_ view: UILabel, context: Context) {
        label.text = text
    }
}
