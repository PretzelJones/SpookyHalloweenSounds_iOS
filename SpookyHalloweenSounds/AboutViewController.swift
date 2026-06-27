//
//  AboutViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI

final class AboutViewController: UIHostingController<AboutView> {

    private var titleHostingVC: UIHostingController<PaletteText>?
    private var backIconHostingVC: UIHostingController<PaletteIconView>?
    private var keyHostingVC: UIHostingController<PaletteIconView>?

    required init?(coder: NSCoder) {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build   = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        super.init(coder: coder, rootView: AboutView(versionText: "Version \(version) (\(build))"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleHC = UIHostingController(rootView: PaletteText(text: "App Information", font: .custom("Creepster", size: 28)))
        titleHC.view.backgroundColor = .clear
        titleHC.view.frame = CGRect(x: 0, y: 0, width: 280, height: 44)
        navigationItem.titleView = titleHC.view
        titleHostingVC = titleHC
        navigationItem.largeTitleDisplayMode = .never

        let keyHC = UIHostingController(rootView: PaletteIconView(imageName: "plain_key"))
        keyHC.view.backgroundColor = .clear
        keyHC.view.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        keyHC.view.isUserInteractionEnabled = false
        keyHostingVC = keyHC

        let keyButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        keyButton.addSubview(keyHC.view)
        keyHC.view.center = CGPoint(x: 22, y: 22)
        keyButton.addAction(UIAction { [weak self] _ in
            self?.performSegue(withIdentifier: "showHidden", sender: self)
        }, for: .touchUpInside)

        let keyItem = UIBarButtonItem(customView: keyButton)
        if #available(iOS 26.0, *) {
            keyItem.hidesSharedBackground = true
        }
        navigationItem.rightBarButtonItem = keyItem

        let backHC = UIHostingController(rootView: PaletteIconView(imageName: "left_arrow"))
        backHC.view.backgroundColor = .clear
        backHC.view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        backHC.view.isUserInteractionEnabled = false
        backIconHostingVC = backHC

        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        backButton.addSubview(backHC.view)
        backHC.view.center = CGPoint(x: 22, y: 22)
        backButton.addAction(UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)

        let backItem = UIBarButtonItem(customView: backButton)
        if #available(iOS 26.0, *) {
            backItem.hidesSharedBackground = true
        }
        navigationItem.leftBarButtonItem = backItem

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
