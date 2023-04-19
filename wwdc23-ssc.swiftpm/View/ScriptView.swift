//
//  ScriptView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct ScriptView: View {
    @ObservedObject var viewModel: ScriptViewModel
    @State private var isTriangleHidden: Bool = false
    
    init(taskManager: TaskManager) {
        viewModel = ScriptViewModel(taskManager: taskManager)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .opacity(0.01)
            GeometryReader { geometry in
                ScriptUIView(
                    text: viewModel.displayingScript,
                    width: geometry.size.width
                )
            }
            .padding(32)
            HStack {
                Text(viewModel.getPage())
                    .foregroundColor(.white)
                    .font(.caption)
                Spacer()
                if viewModel.hasNextButton() {
                    BlinkingTriangle(sizeLength: 20, color: .white)
                }
            }
            .frame(height: 20)
            .padding(16)
        }
        .onTapGesture {
            viewModel.gotoNextScript()
        }
    }
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        let taskManager = TaskManager()
        return ScriptView(taskManager: taskManager)
    }
}
