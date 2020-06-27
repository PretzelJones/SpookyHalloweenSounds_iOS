//
//  PulseAnimation2.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/13/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIButton {
    
    @IBAction func pulsate2(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.150,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
                            self.showsTouchWhenHighlighted = false
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.150, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
    }
    
}
