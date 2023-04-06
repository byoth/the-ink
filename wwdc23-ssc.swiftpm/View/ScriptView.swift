//
//  ScriptView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct ScriptView: View {
    @ObservedObject var progress: SketchingProgress
    
    var text: String {
        "(test)\nThe factory build rate is \(progress.getPercentage())%."
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .font(.headline)
    }
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        let progress = SketchingProgress()
        return ScriptView(progress: progress)
    }
}
