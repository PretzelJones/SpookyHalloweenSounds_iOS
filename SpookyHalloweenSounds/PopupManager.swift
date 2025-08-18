//
//  PopupManager.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/15/23.
//

import UIKit

class PopupManager {
    static let shared = PopupManager()

    private let popupVersionKey = "popupVersionShown"
    private let currentPopupVersion = "1.5" // 🔁 Change when you want the popup to show again

    func shouldShowPopup() -> Bool {
        let shownVersion = UserDefaults.standard.string(forKey: popupVersionKey)
        let shouldShow = (shownVersion != currentPopupVersion)
        print("[PopupManager] Last shown: \(shownVersion ?? "none"), Should show: \(shouldShow)")
        return shouldShow
    }

    func markPopupAsShown() {
        print("[PopupManager] Marking popup version \(currentPopupVersion) as shown.")
        UserDefaults.standard.set(currentPopupVersion, forKey: popupVersionKey)
    }

    func showPopup(inViewController viewController: UIViewController) {
        guard shouldShowPopup() else { return }

        let alertController = UIAlertController(
            title: "New Feature!",
            message: "Hold your finger on the button to restart any of the Movie Theme or Looping Mix sounds!",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.markPopupAsShown()
        }))

        viewController.present(alertController, animated: true)
    }

    // Optional: reset popup manually for testing
    func resetPopupForTesting() {
        UserDefaults.standard.removeObject(forKey: popupVersionKey)
    }
}
