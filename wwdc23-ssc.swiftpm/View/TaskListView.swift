//
//  TaskListView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject private var viewModel: TaskListViewModel
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.viewModel = TaskListViewModel(
            taskManager: taskManager,
            resource: resource,
            progress: progress
        )
    }
    
    var body: some View {
        List {
            ForEach(viewModel.getSections()) { section in
                Section(section.title) {
                    if viewModel.isHidden(section: section) {
                        lockedView()
                    } else {
                        ForEach(section.tasks) { task in
                            taskView(section: section, task: task)
                        }
                    }
                }
                .animation(
                    .easeInOut(duration: 1),
                    value: viewModel.getCurrentStepHashValue()
                )
            }
        }
        .onAppear {
            // TODO: 대신 Script 연동
            DispatchQueue.main.async {
                self.viewModel.taskManager.gotoNextTask()
            }
        }
    }
    
    private func lockedView() -> some View {
        HStack {
            Spacer()
            Text("🔒")
                .font(.largeTitle)
            Spacer()
        }
        .frame(height: 120)
    }
    
    private func taskView(section: TaskSection, task: Task) -> some View {
        Group {
            let isActive = viewModel.isActive(section: section, task: task)
            HStack {
                Text(task.title)
                Spacer()
                if viewModel.isCompleted(section: section, task: task) {
                    Text("✅")
                } else if isActive {
                    ProgressView()
                }
            }
            if let progress = task.progress, isActive {
                progressView(progress: progress)
            }
        }
    }
    
    private func progressView(progress: TaskProgress) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(progress.title)
                .foregroundColor(.gray)
                .font(.caption)
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.orange)
                    .frame(width: geometry.size.width * viewModel.getCurrentGaugeRate())
                    .animation(
                        .interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5),
                        value: viewModel.getCurrentGaugeRate()
                    )
            }
            .background(Color.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(height: 16)
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 8))
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let taskManager = TaskManager()
        let progress = SketchingProgress()
        let resource = SketchingResource()
        return TaskListView(
            taskManager: taskManager,
            resource: resource,
            progress: progress
        )
    }
}
