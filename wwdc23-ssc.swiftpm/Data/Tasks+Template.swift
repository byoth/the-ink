//
//  Tasks+Template.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/08.
//

import Foundation

extension TaskSection {
    static let Introduction = TaskSection(
        title: "0. INTRODUCTION",
        isShownInList: false,
        isSketchable: false,
        tasks: [
            Task.Introduction
        ]
    )
    
    static let GetResources = TaskSection(
        title: "1. GET RESOURCES",
        tasks: [
            Task.RemoveForest,
            Task.RemovePond,
            Task.RemoveRocks,
            Task.FillInkGauge
        ]
    )
    
    static let MakeProducts = TaskSection(
        title: "2. MAKE PRODUCTS",
        tasks: [
            Task.BuildFactory,
            Task.MakeProducts
        ]
    )
    
    static let TurnEverythingBack = TaskSection(
        title: "3. TURN EVERYTHING BACK!",
        tasks: [
        ]
    )
}

extension Task {
    static let Introduction = Task(
        title: "Introduction",
        scripts: [
            "Hello, Player!",
            "We gonna do blahblah. blahblahblah. blahblah. blahblahblah."
        ]
    )
    
    static let RemoveForest = Task(
        title: "Remove the forest"
    )
    
    static let RemovePond = Task(
        title: "Remove the pond"
    )
    
    static let RemoveRocks = Task(
        title: "Remove the rocks"
    )
    
    static let FillInkGauge = Task(
        title: "Fill the ink gauge",
        scripts: [
            "Fill the ink gauge~"
        ],
        progress: TaskProgress(
            title: "INK GAUGE",
            layerTypes: [.forFactory],
            gaugeType: SketchingResource.self,
            startingBackgroundRGB: SkyRGB.first,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let BuildFactory = Task(
        title: "Build a factory",
        progress: TaskProgress(
            title: "BUILD RATE",
            layerTypes: [.factoryGuideline, .forFactory],
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.second,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let MakeProducts = Task(
        title: "Make products",
        progress: TaskProgress(
            title: "PRODUCTION RATE",
            layerTypes: [.forFactory, .pollutionGuideline, .forPollution],
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.fourth
        )
    )
}
