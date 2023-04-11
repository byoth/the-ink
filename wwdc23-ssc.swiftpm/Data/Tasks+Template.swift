//
//  Tasks+Template.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

extension TaskSection {
    static let GetResources = TaskSection(
        title: "1. GET RESOURCES",
        tasks: [
            Task.RemoveForest,
            Task.RemovePond,
            Task.RemoveRocks,
            Task.FillInkGauge
        ]
    )
    
    static let BuildFactory = TaskSection(
        title: "2. BUILD A FACTORY",
        tasks: [
            Task.MakeConstructionSite,
            Task.BuildFactory
        ]
    )
    
    static let MakeProducts = TaskSection(
        title: "3. MAKE PRODUCTS",
        isSketchable: false,
        tasks: [
            Task.AirPollution,
            Task.WaterPollution,
            Task.MakeProducts
        ]
    )
}

extension Task {
    static let RemoveForest = Task(
        title: "Remove the forest",
        isSkippable: true
    )
    
    static let RemovePond = Task(
        title: "Remove the pond",
        isSkippable: true
    )
    
    static let RemoveRocks = Task(
        title: "Remove the rocks",
        isSkippable: true
    )
    
    static let FillInkGauge = Task(
        title: "Fill the ink gauge",
        progress: TaskProgress(
            title: "INK GAUGE",
            layerTypes: [.background, .foreground],
            gaugeType: SketchingResource.self,
            startingBackgroundRGB: SkyRGB.first,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let MakeConstructionSite = Task(
        title: "Make a construction site",
        progress: TaskProgress(
            title: "BUILD RATE",
            layerTypes: [.background, .constructionSiteGuideline, .foreground],
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.second,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let BuildFactory = Task(
        title: "Build a factory",
        progress: TaskProgress(
            title: "BUILD RATE",
            layerTypes: [.background, .factoryGuideline, .foreground],
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.fourth
        )
    )
    
    static let AirPollution = Task(
        title: "Air Pollution",
        isSkippable: true
    )
    
    static let WaterPollution = Task(
        title: "Water Pollution",
        isSkippable: true
    )
    
    static let MakeProducts = Task(
        title: "Make products",
        progress: TaskProgress(
            title: "PRODUCTION RATE",
            layerTypes: [.background, .foreground],
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.fourth,
            endingBackgroundRGB: SkyRGB.fifth
        )
    )
}
