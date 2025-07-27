//
//  AVPlaver+Ding.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 25/07/2025.
//

import AVFoundation
import Foundation

extension AVPlayer{
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {fatalError("Failed to find sound file")}
        return AVPlayer(url: url)
    }()
}
