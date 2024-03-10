//
//  SoundPlayer.swift
//  CoffeeOrder
//
//  Created by Pavel on 21.02.2024.
//

import AVFoundation

final class SoundPlayer {
    //MARK: - Property
    static let shared = SoundPlayer()
    var player = AVAudioPlayer()
    
    //MARK: - Init
    private init() {}
    
    //MARK: - Actions
    func playSound() {
        guard let url = Bundle.main.url(forResource: "paySound", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player.numberOfLoops = 0
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
