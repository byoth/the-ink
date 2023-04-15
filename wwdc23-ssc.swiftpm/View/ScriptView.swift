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
        ZStack(alignment: .bottomTrailing) {
            Color.white
                .opacity(0.01)
            Text(viewModel.getCurrentScript())
                .foregroundColor(.white)
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            if viewModel.hasNext() {
                BlinkingTriangle(sizeLength: 20, color: .white)
            }
        }
        .padding()
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
