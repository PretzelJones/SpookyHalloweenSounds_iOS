//
//  NewFeatureAlert.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/17/25.
//

import UIKit

enum NewFeatureAlert {
    static func make() -> UIAlertController {
        let alert = UIAlertController(
            title: "New Feature!",
            message: "Press, hold and slide your finger across the button to scroll through the long mix, movie and party sounds",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: .default))
        return alert
    }
}
