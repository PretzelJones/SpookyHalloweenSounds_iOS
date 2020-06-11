//
//  PulseAnimation.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/11/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.94
        pulse.toValue = 1.0
        pulse.repeatCount = 0
        pulse.initialVelocity = 1.0
        pulse.damping = 0.1

        layer.add(pulse, forKey: nil)
    }
}
