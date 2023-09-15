//
//  replay.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 7/13/22.
//  Copyright © 2022 Bosson Design. All rights reserved.
//

import AVFoundation
//import Foundation
import UIKit

func handleReplay(for button: UIButton, with player: AVAudioPlayer?) {
    if player?.isPlaying == true {
        player?.stop()
    }
    player?.currentTime = 0
    player!.play();
    player!.numberOfLoops = -1
    button.backgroundColor = halloweenOrangeHighlight
    button.setImage(UIImage(named: "pause"), for: .normal)
}
