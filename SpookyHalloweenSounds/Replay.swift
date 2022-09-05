//
//  replay.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 7/13/22.
//  Copyright © 2022 Bosson Design. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBAction func replay(_ gestureRecognizer: UILongPressGestureRecognizer) {

       if gestureRecognizer.state == .began {
           if ((player?.isPlaying) != nil) {
               player?.pause()
           }
           player?.currentTime = 0
           player?.play()
           
       }
    }
}
