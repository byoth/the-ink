import SwiftUI

struct ContentView: View {
    @StateObject private var resource = DrawingResource()
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                CanvasView(resource: resource)
            }
            .padding()
        }
    }
}
