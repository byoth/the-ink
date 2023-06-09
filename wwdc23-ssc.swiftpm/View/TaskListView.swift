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
                    if viewModel.taskManager.isHidden(section: section) {
                        lockedView()
                    } else {
                        ForEach(section.tasks) { task in
                            taskView(section: section, task: task)
                        }
                    }
                }
            }
        }
        .animation(
            .easeInOut(duration: 0.5),
            value: viewModel.taskManager.getCurrentTask()
        )
        .sheet(isPresented: $viewModel.hasCurrentModal) {
            if let modal = viewModel.taskManager.currentModal {
                modalView(modal: modal)
                    .onDisappear {
                        viewModel.taskManager.gotoNextTask()
                    }
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
            let isActive = viewModel.taskManager.isActive(section: section, task: task)
            HStack {
                Text(task.title)
                Spacer()
                if viewModel.isCompleted(section: section, task: task) {
                    Text("✅")
                } else if isActive {
                    if !viewModel.taskManager.isLast(task: task) {
                        ProgressView()
                    } else {
                        Text("👍")
                    }
                }
            }
            if let progress = task.progress,
               task == viewModel.taskManager.getCurrentTask() && isActive {
                progressView(progress: progress)
            }
        }
    }
    
    private func progressView(progress: TaskProgress) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            let rate = viewModel.taskManager.currentProgressRate
            Text(progress.title)
                .foregroundColor(.gray)
                .font(.caption)
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.orange)
                    .frame(width: geometry.size.width * rate)
                    .animation(
                        .interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5),
                        value: rate
                    )
            }
            .background(Color.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(height: 16)
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 8))
    }
    
    private func modalView(modal: TaskModal) -> some View {
        Group {
            switch modal {
            case .metaphor:
                MetaphorView()
            case .productsAreMade:
                ProductsAreMadeView()
            case .natureCanBeRestored:
                NatureCanBeRestoredView()
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let taskManager = TaskManager()
        let resource = SketchingResource()
        let progress = SketchingProgress()
        return TaskListView(
            taskManager: taskManager,
            resource: resource,
            progress: progress
        )
    }
}
