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
    
    @IBAction func pulsate(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.080,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.080, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        UIButton.transition(with: sender, duration: 0.3, options: .curveEaseInOut, animations: {
            
            self.backgroundColor = halloweenOrangeHighlight
            
            if (self.backgroundColor == halloweenOrange) {
                self.backgroundColor = halloweenOrangeHighlight
            }else{
                self.backgroundColor = halloweenOrange
            }
        }, completion: nil)
    }
    
}
