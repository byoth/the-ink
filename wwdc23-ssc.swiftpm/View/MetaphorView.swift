//
//  MetaphorView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/19.
//

import SwiftUI

struct MetaphorView: View {
    @State private var isTextShown = false
    
    var body: some View {
        ZStack {
            Image("inks")
                .resizable()
                .scaledToFill()
                .opacity(0.1)
            VStack(spacing: 16) {
                Text("Wouldn't")
                    .fontWeight(.bold)
                Text("getting inks from pictures")
                    .fontWeight(.black)
                Text("be similar to")
                    .fontWeight(.bold)
                Text("getting resources from nature?")
                    .fontWeight(.black)
            }
            .opacity(isTextShown ? 1 : 0)
            .offset(y: isTextShown ? 0 : 40)
            .multilineTextAlignment(.center)
            .font(.system(size: 24))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear {
            AudioPlayer.shared.play("weap")
            withAnimation(.easeOut(duration: 1).delay(0.5)) {
                isTextShown = true
            }
        }
    }
}

struct MetaphorView_Previews: PreviewProvider {
    static var previews: some View {
        MetaphorView()
    }
}
