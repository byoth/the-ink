//
//  AudioPlayer.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/19.
//

import AVFoundation

final class AudioPlayer {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?
    
    private init() {
    }
    
    func play(_ fileName: String, _ fileExtension: String = "wav") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let player = Self.getPlayer(url: url) else {
            return
        }
        self.player = player
        player.play()
    }
    
    func stop() {
        player?.stop()
    }
    
    private static func getPlayer(url: URL) -> AVAudioPlayer? {
        guard let player = try? AVAudioPlayer(contentsOf: url) else {
            return nil
        }
        player.numberOfLoops = 0
        return player
    }
}
