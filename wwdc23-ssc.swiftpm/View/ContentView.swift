import SwiftUI

struct ContentView: View {
    @StateObject var fourier: Fourier = .init()
    
    var body: some View {
        HStack {
            SketchView(fourier: fourier)
        }
        .ignoresSafeArea()
    }
}
