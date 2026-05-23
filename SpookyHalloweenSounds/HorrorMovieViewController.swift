//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI

final class HorrorMovieViewController: UIHostingController<HorrorMovieView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: HorrorMovieView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.text = "Horror Movie & TV Themes"
        titleLabel.font = UIFont(name: "Creepster", size: 28) ?? UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = halloweenOrange
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        navigationItem.largeTitleDisplayMode = .never

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }
}
