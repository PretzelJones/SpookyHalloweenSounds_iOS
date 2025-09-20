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
            message: "Press and hold a button, then slide your finger to fast-forward or rewind the sound",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: .default))
        return alert
    }
}
