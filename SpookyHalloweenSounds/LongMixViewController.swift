//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI

final class LongMixViewController: UIHostingController<LongMixView> {

    private var titleHostingVC: UIHostingController<PaletteText>?
    private var backIconHostingVC: UIHostingController<PaletteIconView>?

    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: LongMixView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleHC = UIHostingController(rootView: PaletteText(text: "Looping Mixes", font: .custom("Creepster", size: 28)))
        titleHC.view.backgroundColor = .clear
        titleHC.view.frame = CGRect(x: 0, y: 0, width: 280, height: 44)
        navigationItem.titleView = titleHC.view
        titleHostingVC = titleHC
        navigationItem.largeTitleDisplayMode = .never

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
