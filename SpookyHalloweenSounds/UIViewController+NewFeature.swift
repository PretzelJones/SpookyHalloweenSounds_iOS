//
//  UIViewController+NewFeature.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/17/25.
//

import UIKit

extension UIViewController {
    func presentNewFeatureOnce() {
        guard presentedViewController == nil,
              FirstRunGate.consumeOnce(key: FeatureFlags.newFeatureV1Seen) else { return }
        present(NewFeatureAlert.make(), animated: true)
    }
}
