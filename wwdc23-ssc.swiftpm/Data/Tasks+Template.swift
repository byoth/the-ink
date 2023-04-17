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
        canAnimalBeFleeing: true,
        tasks: [
            Task.RemoveTrees,
            Task.RemovePond,
            Task.RemoveSandyBeach,
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
            Task.RemovePollution,
            Task.RemoveFactory,
            Task.RecoverNature
        ]
    )
}

extension Task {
    static let Introduction = Task(
        title: "Introduction",
        layers: [.nature],
        scripts: [
            "Hello, Player!",
            "We gonna do blahblah. blahblahblah. blahblah. blahblahblah."
        ]
    )
    
    static let RemoveTrees = Task(
        title: "Remove the trees"
    )
    
    static let RemovePond = Task(
        title: "Remove the pond"
    )
    
    static let RemoveSandyBeach = Task(
        title: "Remove the sandy beach"
    )
    
    static let FillInkGauge = Task(
        title: "Fill the ink gauge",
        layers: [.emptyGuideline, .nature],
        scripts: [
            "Fill the ink gauge~"
        ],
        progress: TaskProgress(
            title: "INK GAUGE",
            gaugeType: SketchingResource.self,
            sketchingTolerance: 1.1,
            startingBackgroundRGB: SkyRGB.first,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let BuildFactory = Task(
        title: "Build a factory",
        layers: [.nature, .factoryGuideline, .forFactory],
        scripts: [
            "Build a factory~"
        ],
        progress: TaskProgress(
            title: "BUILD RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 2,
            startingBackgroundRGB: SkyRGB.second,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let MakeProducts = Task(
        title: "Make products",
        layers: [.nature, .forFactory, .pollutionGuideline, .forPollution],
        scripts: [
            "Make products~"
        ],
        progress: TaskProgress(
            title: "PRODUCTION RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 2,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.fourth
        )
    )
    
    static let RemovePollution = Task(
        title: "Remove the pollution",
        layers: [.nature, .forFactory, .emptyGuideline, .forPollution],
        scripts: [
            "Remove the pollution~"
        ],
        progress: TaskProgress(
            title: "RECOVERING RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 1.1,
            startingBackgroundRGB: SkyRGB.fourth,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let RemoveFactory = Task(
        title: "Remove a factory",
        layers: [.nature, .forPollution, .emptyGuideline, .forFactory],
        scripts: [
            "Remove a factory~"
        ],
        progress: TaskProgress(
            title: "RECOVERING RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 1.1,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let RecoverNature = Task(
        title: "Recover nature",
        layers: [.emptyGuideline, .forFreeDrawing],
        scripts: [
            "Recover nature~"
        ]
    )
}
