//
//  ViewController.swift
//  SpookyHalloweenSounds
//

import UIKit
import SwiftUI
import AVFoundation
import StoreKit

final class ViewController: UIHostingController<SoundboardView> {

    private let soundModel: SoundboardViewModel
    var countdownTimer: Timer?
    let countdownManager = CountdownManager()
    private var titleHostingVC: UIHostingController<PaletteText>?
    private var batsHostingVC: UIHostingController<PaletteIconView>?
    private var pumpkinHostingVC: UIHostingController<PaletteIconView>?

    required init?(coder: NSCoder) {
        let model = SoundboardViewModel()
        soundModel = model
        super.init(coder: coder, rootView: SoundboardView(model: model))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        startCountdownTimer()
        setupNavigationTitleWithCountdown()

        installPaletteRightBarButton()

        rootView.onNavigate = { [weak self] destination in
            guard let self, let sb = self.storyboard else { return }
            let identifier: String
            switch destination {
            case .loopingMixes:  identifier = "LongMixViewController"
            case .horrorMovies:  identifier = "HorrorMovieViewController"
            case .partySongs:    identifier = "PartySongsViewController"
            }
            let vc = sb.instantiateViewController(withIdentifier: identifier)
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

    func startCountdownTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateCountdownText), userInfo: nil, repeats: true)
    }

    func setupNavigationTitleWithCountdown() {
        let batsHC = UIHostingController(rootView: PaletteIconView(imageName: "bats"))
        batsHC.view.backgroundColor = .clear
        batsHC.view.translatesAutoresizingMaskIntoConstraints = false
        batsHC.view.isUserInteractionEnabled = false
        batsHostingVC = batsHC

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.addSubview(batsHC.view)

        NSLayoutConstraint.activate([
            batsHC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            batsHC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            batsHC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            batsHC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 40)
        ])

        let imageItem = UIBarButtonItem(customView: containerView)

        if #available(iOS 26.0, *) {
            imageItem.hidesSharedBackground = true
        }

        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -15

        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]

        let hc = UIHostingController(rootView: PaletteText(text: countdownManager.getCountdownText(), font: .custom("Creepster", size: 22)))
        hc.view.backgroundColor = .clear
        hc.view.frame = CGRect(x: 0, y: 0, width: 280, height: 44)
        navigationItem.titleView = hc.view
        titleHostingVC = hc
    }

    private func installPaletteRightBarButton() {
        let pumpkinHC = UIHostingController(rootView: PaletteIconView(imageName: "pumpkin"))
        pumpkinHC.view.backgroundColor = .clear
        pumpkinHC.view.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        pumpkinHC.view.isUserInteractionEnabled = false
        pumpkinHostingVC = pumpkinHC

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.addSubview(pumpkinHC.view)
        pumpkinHC.view.center = CGPoint(x: 22, y: 22)
        button.addAction(UIAction { [weak self] _ in
            self?.performSegue(withIdentifier: "showAbout", sender: self)
        }, for: .touchUpInside)

        let item = UIBarButtonItem(customView: button)
        if #available(iOS 26.0, *) {
            item.hidesSharedBackground = true
        }
        navigationItem.rightBarButtonItem = item
    }

    @objc func updateCountdownText() {
        titleHostingVC?.rootView = PaletteText(text: countdownManager.getCountdownText(), font: .custom("Creepster", size: 22))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countdownTimer?.invalidate()
        soundModel.pauseAll()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCountdownTimer()
        if let scene = view.window?.windowScene {
        //    SKStoreReviewController.requestReview(in: scene)
        }
    }
}
