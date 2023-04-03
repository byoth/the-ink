import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.accentColor
            VStack {
                CanvasView()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}
