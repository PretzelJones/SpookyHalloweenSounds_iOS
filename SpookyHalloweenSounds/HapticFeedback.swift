//
//  HapticFeedback.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/13/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBAction func haptic(_ sender: UIButton) {
        
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        
    }
    
}
