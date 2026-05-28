//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI

final class LongMixViewController: UIHostingController<LongMixView> {

    private var titleHostingVC: UIHostingController<PaletteText>?

    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: LongMixView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleHC = UIHostingController(rootView: PaletteText(text: "Looping Mixes", font: .custom("Creepster", size: 22)))
        titleHC.view.backgroundColor = .clear
        titleHC.view.frame = CGRect(x: 0, y: 0, width: 280, height: 44)
        navigationItem.titleView = titleHC.view
        titleHostingVC = titleHC
        navigationItem.largeTitleDisplayMode = .never

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideLeadingGlassBackgrounds()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        hideLeadingGlassBackgrounds()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }

    private func hideLeadingGlassBackgrounds() {
        guard #available(iOS 26.0, *) else { return }
        navigationItem.leftBarButtonItem?.hidesSharedBackground = true
        navigationItem.leftBarButtonItems?.forEach { $0.hidesSharedBackground = true }
        navigationItem.leadingItemGroups.forEach { group in
            group.barButtonItems.forEach { $0.hidesSharedBackground = true }
        }
    }
}
