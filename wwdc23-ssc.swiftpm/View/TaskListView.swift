//
//  TaskListView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/06.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject private var viewModel: TaskListViewModel
    
    init(sections: [TaskSection],
         progress: SketchingProgress) {
        viewModel = TaskListViewModel(
            sections: sections,
            progress: progress
        )
    }
    
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section(section.title) {
                    if viewModel.isHidden(section: section) {
                        lockedView()
                    } else {
                        ForEach(section.tasks) { task in
                            let isActive = viewModel.isActive(section: section, task: task)
                            HStack {
                                Text(task.title)
                                Spacer()
                                if viewModel.isCompleted(task: task) {
                                    Text("✅")
                                } else if isActive {
                                    ProgressView()
                                }
                            }
                            if let gauge = task.gauge, isActive {
                                gaugeView(gauge: gauge)
                            }
                        }
                    }
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
    
    private func gaugeView(gauge: TaskGauge) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(gauge.title)
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
        let progress = SketchingProgress()
        return TaskListView(
            sections: [.GetResources, .BuildFactory, .MakeProducts],
            progress: progress
        )
    }
}
