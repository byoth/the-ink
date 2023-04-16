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
            Task.RemoveFactory
        ]
    )
}

extension Task {
    static let Introduction = Task(
        title: "Introduction",
        layers: [.forFactory],
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
        layers: [.emptyGuideline, .forFactory],
        scripts: [
            "Fill the ink gauge~"
        ],
        progress: TaskProgress(
            title: "INK GAUGE",
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.first,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let BuildFactory = Task(
        title: "Build a factory",
        layers: [.factoryGuideline, .forFactory],
        progress: TaskProgress(
            title: "BUILD RATE",
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.second,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let MakeProducts = Task(
        title: "Make products",
        layers: [.forFactory, .pollutionGuideline, .forPollution],
        progress: TaskProgress(
            title: "PRODUCTION RATE",
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.fourth
        )
    )
    
    static let RemovePollution = Task(
        title: "Remove Pollution",
        layers: [.forFactory, .emptyGuideline, .forPollution],
        progress: TaskProgress(
            title: "RECOVERING RATE",
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.fourth,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let RemoveFactory = Task(
        title: "Remove Factory",
        layers: [.forPollution, .emptyGuideline, .forFactory],
        progress: TaskProgress(
            title: "RECOVERING RATE",
            gaugeType: SketchingProgress.self,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let RecoverNature = Task(
        title: "Recover Nature",
        layers: [.emptyGuideline, .forFactory]
    )
}
