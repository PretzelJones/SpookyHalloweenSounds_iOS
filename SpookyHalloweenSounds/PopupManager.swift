//
//  PopupManager.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/15/23.
//

import UIKit

class PopupManager {
    static let shared = PopupManager() // Singleton instance

    private let userDefaultsKey = "popupShown"

    func shouldShowPopup() -> Bool {
        return !UserDefaults.standard.bool(forKey: userDefaultsKey)
    }

    func markPopupAsShown() {
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
    }

    func showPopup(inViewController viewController: UIViewController) {
        if shouldShowPopup() {
            let alertController = UIAlertController(title: "New Feature!", message: "Hold your finger on the button to restart any of the Movie Theme or Looping Mix sounds!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Handle the OK button tap if needed
                self.markPopupAsShown()
            }))
            
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}

