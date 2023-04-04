import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Color.white
                        .cornerRadius(24)
                        .shadow(radius: 16, y: 8)
                    CanvasView(drawing: .background, isBackground: true)
                    CanvasView(drawing: .foreground)
                    ResourceGaugeView(resource: DrawingResource())
                }
                .aspectRatio(1 / 1, contentMode: .fit)
            }
            .padding()
        }
    }
}
