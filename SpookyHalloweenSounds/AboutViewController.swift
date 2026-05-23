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

        navigationItem.title = "App Information"
        navigationItem.hidesBackButton = true

        if let img = UIImage(named: "left_arrow")?.withRenderingMode(.alwaysTemplate) {
            let back = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(onBack))
            back.tintColor = halloweenOrange
            if #available(iOS 26.0, *) { back.hidesSharedBackground = true }
            navigationItem.leftBarButtonItem = back
        }

        // Keep the storyboard's right bar button item so its segue to HiddenViewController stays wired.
        if let keyItem = navigationItem.rightBarButtonItem {
            keyItem.tintColor = halloweenOrange
            if #available(iOS 26.0, *) { keyItem.hidesSharedBackground = true }
        }

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
}
