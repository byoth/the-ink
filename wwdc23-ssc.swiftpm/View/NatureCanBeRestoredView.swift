//
//  NatureCanBeRestoredView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/18.
//

import SwiftUI

struct NatureCanBeRestoredView: View {
    @State private var isShown = false
    
    var body: some View {
        ZStack {
            Image("restore")
                .resizable()
                .scaledToFill()
            
            VStack {
                Text("Nature can be restored!")
                    .font(.system(size: 32, weight: .bold))
                    .padding()
                    .offset(y: isShown ? 0 : -40)
                
                VStack(spacing: 16) {
                    Text("We've the opportunity to restore nature.\nBut there is no such opportunity in reality.")
                    Text("Not all factories destroy nature,\nbut it's definitely happening somewhere.")
                    Text("It's hard for us to live without products,\nbut at least we can pay attention to the way eco-friendly products are made.")
                    Text("Our efforts can be put together to prevent ecological catastrophe.")
                }
                .font(.system(size: 16, weight: .light))
                .padding()
                .offset(y: isShown ? 0 : 40)
            }
        }
        .opacity(isShown ? 1 : 0)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear {
            AudioPlayer.shared.play("peaceful")
            withAnimation(.easeOut(duration: 3)) {
                isShown = true
            }
        }
    }
}

struct NatureCanBeRestoredView_Previews: PreviewProvider {
    static var previews: some View {
        NatureCanBeRestoredView()
    }
}
