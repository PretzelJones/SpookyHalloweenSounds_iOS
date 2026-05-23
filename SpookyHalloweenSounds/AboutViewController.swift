//
//  AboutViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI

final class AboutViewController: UIHostingController<AboutView> {

    required init?(coder: NSCoder) {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build   = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        super.init(coder: coder, rootView: AboutView(versionText: "Version \(version) (\(build))"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.text = "App Information"
        titleLabel.font = UIFont(name: "Creepster", size: 28) ?? UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = halloweenOrange
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        navigationItem.largeTitleDisplayMode = .never

        // Keep the storyboard's right bar button item so its segue to HiddenViewController stays wired.
        if let keyItem = navigationItem.rightBarButtonItem {
            keyItem.tintColor = halloweenOrange
            if #available(iOS 26.0, *) { keyItem.hidesSharedBackground = true }
        }

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
