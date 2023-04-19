//
//  MetaphorView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/19.
//

import SwiftUI

struct MetaphorView: View {
    var body: some View {
        Text("Metaphor")
            .onAppear {
                AudioPlayer.shared.play("weap")
            }
    }
}

struct MetaphorView_Previews: PreviewProvider {
    static var previews: some View {
        MetaphorView()
    }
}
