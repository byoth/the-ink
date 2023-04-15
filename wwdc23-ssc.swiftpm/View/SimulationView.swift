//
//  SimulationView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct SimulationView: View {
    @StateObject private var viewModel = SimulationViewModel()
    @State private var isBackgroundHidden = true
    @State private var isCanvasHidden = true
    @State private var isSideHidden = true
    
    var body: some View {
        ZStack {
            backgroundView()
            HStack(spacing: 0) {
                if !isSideHidden {
                    sideView()
                        .transition(.slide)
                }
                canvasView()
                    .layoutPriority(1)
            }
        }
        .onAppear {
            animateToAppear()
            
            // TODO: 대신 Script 연동
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.viewModel.taskManager.gotoNextTask()
            }
        }
    }
    
    private func backgroundView() -> some View {
        SkyBackgroundView(
            taskManager: viewModel.taskManager,
            resource: viewModel.resource,
            progress: viewModel.progress
        )
        .opacity(isBackgroundHidden ? 0 : 1)
        .ignoresSafeArea()
    }
    
    private func sideView() -> some View {
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
    }
    
    private func canvasView() -> some View {
        CanvasView(
            allLayers: viewModel.allLayers,
            resource: viewModel.resource,
            progress: viewModel.progress,
            taskManager: viewModel.taskManager,
            receiver: viewModel.receiver,
            isIntroduction: !isCanvasHidden && isSideHidden
        )
        .opacity(isCanvasHidden ? 0 : 1)
        .offset(y: isCanvasHidden ? 100 : 0)
        .padding(32)
    }
    
    private func animateToAppear() {
        withAnimation(.easeInOut(duration: 1).delay(0.5)) {
            isBackgroundHidden = false
        }
        withAnimation(.easeInOut(duration: 1).delay(1)) {
            isCanvasHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.spring()) {
                isSideHidden = false
            }
        }
    }
}

struct SimulationView_Previews: PreviewProvider {
    static var previews: some View {
        SimulationView()
    }
}
