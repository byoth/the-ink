//
//  ProductsAreMadeView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/18.
//

import SwiftUI

struct ProductsAreMadeView: View {
    @State private var isItemFloating = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let iconSizeLength = geometry.size.height * (2 / 3)
                ZStack(alignment: .bottom) {
                    Color.gray
                    Color.black
                        .offset(y: iconSizeLength / 2 - CGFloat(isItemFloating ? 20 : 0))
                        .frame(
                            width: iconSizeLength,
                            height: iconSizeLength
                        )
                }
            }
            .aspectRatio(3 / 1, contentMode: .fit)
            
            Spacer()
            
            VStack(spacing: 24) {
                Text("You've got the products!")
                    .font(.system(size: 32, weight: .bold))
                Text("But···\nHave you noticed how many things are sacrificed for these?")
                    .font(.system(size: 24, weight: .black))
            }
            .multilineTextAlignment(.center)
            .padding()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("We made a big mistake for our needs.\nNature is destroyed. Animals left. We can no longer see a peaceful place.")
                Text("Fortunately, we're in the game, so we can turn everything back from now on.")
                Text("Unfortunately, humans are making same mistakes as us in the real world.\nAnd it's almost irreversible.")
            }
            .font(.system(size: 16, weight: .light))
            .padding()
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                isItemFloating.toggle()
            }
        }
    }
}

struct ProductsAreMadeView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsAreMadeView()
    }
}
