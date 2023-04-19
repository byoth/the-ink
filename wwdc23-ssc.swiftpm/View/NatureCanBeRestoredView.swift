//
//  NatureCanBeRestoredView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/18.
//

import SwiftUI

struct NatureCanBeRestoredView: View {
    var body: some View {
        Text("Nature Can Be Restored!")
            .onAppear {
                AudioPlayer.shared.play("weap")
            }
    }
}

struct NatureCanBeRestoredView_Previews: PreviewProvider {
    static var previews: some View {
        NatureCanBeRestoredView()
    }
}
