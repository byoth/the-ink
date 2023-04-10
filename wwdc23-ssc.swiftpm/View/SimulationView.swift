//
//  SimulationView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct SimulationView: View {
    @StateObject private var viewModel = SimulationViewModel()
    
    var body: some View {
        ZStack {
            SkyBackgroundView(
                taskManager: viewModel.taskManager,
                resource: viewModel.resource,
                progress: viewModel.progress
            )
            .ignoresSafeArea()
            HStack(spacing: 0) {
                ZStack {
                    Color.white
                        .opacity(0.1)
                        .ignoresSafeArea()
                    VStack {
                        ScriptView(text: "Hello, world!")
                            .frame(height: 160)
                            .padding()
                        TaskListView(
                            taskManager: viewModel.taskManager,
                            resource: viewModel.resource,
                            progress: viewModel.progress
                        )
                    }
                }
                CanvasView(
                    resource: viewModel.resource,
                    progress: viewModel.progress,
                    taskManager: viewModel.taskManager
                )
                .padding(32)
                .layoutPriority(1)
            }
        }
    }
}

struct SimulationView_Previews: PreviewProvider {
    static var previews: some View {
        SimulationView()
    }
}
