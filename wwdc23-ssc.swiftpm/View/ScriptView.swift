//
//  ScriptView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct ScriptView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .font(.headline)
    }
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptView(text: "Hello, world!")
    }
}
