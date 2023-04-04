import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                CanvasView()
            }
            .padding()
        }
    }
}
