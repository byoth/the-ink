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
        layers: [.nature],
        scripts: [
            "Hello, Player!",
            "This game simulates how to make some products we use.",
            "You'll draw a few pictures of what we need to make products, following guidelines I'll provide.",
            "But to draw in this game, you've to consume inks.\nAnd to get inks, you've to erase already drawn pictures.",
            "This is the only rule this game has.\nSo let's give it a try."
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
            "You'll build a factory by drawing.\nBut as you know, you need inks to do this.",
            "So fill the ink gauge by erasing the natural elements like trees, pond, and sandy beach with the eraser tool.",
            "You can always check the ink gauge at the bottom right."
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
            "Now you can build a factory because you got inks.",
            "And it can be a metaphor for industries having to get resources and space from nature.",
            "Anyway, it'll be built if you draw a factory tracing the sketch.",
            "Please be sure to trace as accurately as possible."
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
            "Now you can run the factory.\nBut production causes air pollution, water pollution, and waste problems.",
            "You should consider this.\nAs before, draw pollution tracing the sketch to make products."
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
            "We've realized to should turn everything back.\nLet's restore nature!",
            "Please erase the pollution!"
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
        title: "Remove the factory",
        layers: [.nature, .forPollution, .emptyGuideline, .forFactory],
        scripts: [
            "Please erase the factory, too!"
        ],
        progress: TaskProgress(
            title: "RECOVERING RATE",
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
            "Now you can draw freely a nature-friendly place as you like!",
            "Not all factories destroy nature,\nBut the terrible things we've done are surely happening somewhere.",
            "It is hard to live without products,\nBut we should pay attention to how eco-friendly our products are made.",
            "Thank you for playing! 👍"
        ]
    )
}
