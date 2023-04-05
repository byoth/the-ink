import SwiftUI

struct ContentView: View {
    @State private var resource = SketchingResource()
    
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
