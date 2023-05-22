# The Ink

[📺 Demonstration](https://www.youtube.com/watch?v=FVY24U38o-w)

This is an iPad app that needs to use Apple Pencil.
Therefore, it is recommended to use an actual device, not a simulator.

This game pretends to be a simulation of production, but it actually sends a message about environmental pollution, side effects of non-environmental production.

Players can visually accept this message while directly destroying and restoring nature drawn with PencilKit.

## Introduction

The rules of this game are simple and clear.

- To draw new pictures, players have to use inks.
- To get inks, players have to erase already drawn pictures.

According to the above rules, this game will be played as follows.

1. I provide players with a picture of peaceful nature.
2. I give players a goal regarding production, and I ask them to draw a factory for that.
3. Players have to erase the peaceful nature to get inks.
4. Players draw a factory with the inks.
5. Players even have to draw environmental pollution from production to make products.
6. When players achieve that goal, I make them aware of the nature that was sacrificed for it, and I send them a message about actual environmental pollution.
7. I give players opportunity to turn everything back, they erase a factory and pollution, and freely restore nature.

## Technical Used

The technical challenges I did are as follows.

- Used MVVM architectural pattern with SwiftUI, and handled the interaction between modules with Combine.
- Converted data of PencilKit into images in real time, and calculated the accuracy of the tracing.

Apple's frameworks used to create this game are as follows.

- PencilKit
- SwiftUI
- Combine
- and a bit of UIKit, AVFoundation.

Apple’s softwares used to test this game as follows.

- Xcode 14.3
- iPadOS 16.4.1

The sites used to get resources for this game are as follows.

- [Stability AI](https://stability.ai/)
- [Freesound](https://freesound.org/)
