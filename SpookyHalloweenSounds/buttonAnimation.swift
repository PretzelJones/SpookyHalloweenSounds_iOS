//
//  buttonAnimation.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/10/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import Foundation
import UIKit

let halloweenOrange = UIColor(red: 243/255, green: 127/255, blue: 54/255, alpha: 1)
let halloweenOrangeHighlight = UIColor(red: 245/255, green: 154/255, blue: 75/255, alpha: 1)

extension UIButton {
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
        }, completion: nil)
    }
}
