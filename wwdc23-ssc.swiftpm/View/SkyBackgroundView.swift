//
//  SkyBackgroundView.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/10.
//

import SwiftUI

struct SkyBackgroundView: View {
    @ObservedObject private var viewModel: SkyBackgroundViewModel
    
    init(taskManager: TaskManager,
         resource: SketchingResource,
         progress: SketchingProgress) {
        self.viewModel = SkyBackgroundViewModel(
            taskManager: taskManager,
            resource: resource,
            progress: progress
        )
    }
    
    var body: some View {
        let rgb = getRGB()
        Color(uiColor: UIColor(red: rgb.0, green: rgb.1, blue: rgb.2, alpha: 1))
            .animation(.linear(duration: 0.3), value: rgb.0 + rgb.1 + rgb.2)
    }
    
    private func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        let rgb = viewModel.getRGB() ?? SkyRGB.first
        return (CGFloat(rgb.0) / 255, CGFloat(rgb.1) / 255, CGFloat(rgb.2) / 255)
    }
}

struct SkyBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        let taskManager = TaskManager()
        let resource = SketchingResource()
        let progress = SketchingProgress()
        return SkyBackgroundView(
            taskManager: taskManager,
            resource: resource,
            progress: progress
        )
    }
}
