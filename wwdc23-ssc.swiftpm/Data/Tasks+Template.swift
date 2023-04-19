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
            Task.RestoreNature
        ]
    )
}

extension Task {
    static let Introduction = Task(
        title: "Introduction",
        layers: [.traces, .nature],
        scripts: [
            "Hello, Player!\n  \nThis game is a simulation of production making what we use in general.",
            "You'll draw a few pictures of facilities and equipment we need to make products,\nfollowing guidelines I'll provide.",
            "But to draw in this game, you've to use inks.\n  \nAnd to get inks, you've to erase already drawn pictures.",
            "This is the only one rule this game has.\n  \nLet's play!"
        ]
    )
    
    static let RemoveTrees = Task(
        title: "Remove trees"
    )
    
    static let RemovePond = Task(
        title: "Remove the pond"
    )
    
    static let RemoveSandyBeach = Task(
        title: "Remove the sandy beach"
    )
    
    static let FillInkGauge = Task(
        title: "Fill the ink gauge",
        layers: [.traces, .emptyGuideline, .nature],
        scripts: [
            "You'll draw a factory to make products.\n  \nBut as you know, you need inks to do this.",
            "So fill the ink gauge by erasing the natural elements.\n  \nYou can use eraser tools.",
            "And you can always check the ink gauge at the bottom right corner."
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
        layers: [.traces, .nature, .factoryGuideline, .forFactory],
        scripts: [
            "Now that you've inks, you can build a factory.",
            "It'll be built if you draw a factory tracing a sketch.",
            "Please draw it as accurately as possible.",
            "TIPS!\n  \nThe lines must match each other in thickness.\n  \nYou shouldn't draw anything other than a sketch, including filling in colors."
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
        layers: [.traces, .nature, .forFactory, .pollutionGuideline, .forPollution],
        scripts: [
            "Now that you've a factory, you can make products.\n  \nBut production causes air pollution, water pollution, and waste problems.",
            "You should consider this to make products.",
            "As before, draw pollution tracing a sketch."
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
        layers: [.traces, .nature, .forFactory, .emptyGuideline, .forPollution],
        scripts: [
            "We've realized, that we should turn everything back.\n  \nLet's restore nature!",
            "Please erase the pollution!"
        ],
        progress: TaskProgress(
            title: "RECOVERY RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 1.1,
            startingBackgroundRGB: SkyRGB.fourth,
            endingBackgroundRGB: SkyRGB.third
        )
    )
    
    static let RemoveFactory = Task(
        title: "Remove the factory",
        layers: [.traces, .nature, .forPollution, .emptyGuideline, .forFactory],
        scripts: [
            "Please erase the factory, too!"
        ],
        progress: TaskProgress(
            title: "RECOVERY RATE",
            gaugeType: SketchingProgress.self,
            sketchingTolerance: 1.1,
            startingBackgroundRGB: SkyRGB.third,
            endingBackgroundRGB: SkyRGB.second
        )
    )
    
    static let RestoreNature = Task(
        title: "Restore nature",
        layers: [.emptyGuideline, .forFreeDrawing],
        scripts: [
            "Now you can draw freely a eco-friendly place as you like!",
            "Thank you for playing 👍"
        ]
    )
}
