//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

final class HorrorMovieViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var halloweenButton: SeekButton!
    @IBOutlet weak var exorcistButton: SeekButton!
    @IBOutlet weak var shiningButton: SeekButton!
    @IBOutlet weak var nightmareButton: SeekButton!
    @IBOutlet weak var fridayButton: SeekButton!
    @IBOutlet weak var amityvilleButton: SeekButton!
    @IBOutlet weak var unsolvedButton: SeekButton!
    @IBOutlet weak var xfilesButton: SeekButton!

    // MARK: - Strong refs
    private var audioPlayers: [SeekButton: AVAudioPlayer] = [:]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        [halloweenButton,
         exorcistButton,
         shiningButton,
         nightmareButton,
         fridayButton,
         amityvilleButton,
         unsolvedButton,
         xfilesButton].forEach { $0?.noHighlight($0!) }

        initializeAudioPlayers()
        
        // Custom back button
        navigationItem.hidesBackButton = true
        if let img = UIImage(named: "left_arrow")?.withRenderingMode(.alwaysTemplate) {
            let backItem = UIBarButtonItem(
                image: img,
                style: .plain,
                target: self,
                action: #selector(onBack)
            )
            backItem.tintColor = halloweenOrange
            if #available(iOS 26.0, *) {
                backItem.hidesSharedBackground = true
            } else {
                // Fallback on earlier versions
            }
            navigationItem.leftBarButtonItem = backItem
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }
    
    @objc private func onBack() { navigationController?.popViewController(animated: true) }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayers.values.forEach { if $0.isPlaying { $0.pause() } }
    }

    // MARK: - Setup
    private func initializeAudioPlayers() {
        let items: [(SeekButton, String)] = [
            (halloweenButton, "halloween"),
            (exorcistButton, "exorcist"),
            (shiningButton, "shining"),
            (nightmareButton, "elm_street"),
            (fridayButton, "vorhees"),
            (amityvilleButton, "amityville"),
            (unsolvedButton, "unsolved_mysteries"),
            (xfilesButton, "xfiles")
        ]

        for (button, sound) in items {
            if let path = Bundle.main.path(forResource: sound, ofType: "mp3")
                ?? Bundle.main.path(forResource: sound, ofType: "wav") {
                do {
                    let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    player.prepareToPlay()
                    player.delegate = self
                    player.numberOfLoops = -1
                    button.player = player
                    audioPlayers[button] = player
                } catch {
                    print("Error loading \(sound): \(error)")
                }
            } else {
                print("File not found: \(sound).mp3/.wav")
            }
        }
    }

    // MARK: - Actions
    @IBAction func soundButtonPressed(_ sender: SeekButton) {
        guard let player = sender.player else { return }

        sender.pulsate(sender)
        sender.haptic(sender)
        sender.showsTouchWhenHighlighted = true

        if player.isPlaying {
            player.pause()
            updateButtonUI(sender, isPlaying: false)
        } else {
            _ = player.play()
            updateButtonUI(sender, isPlaying: true)
        }
    }
    
    // MARK: - UI
    private func updateButtonUI(_ button: SeekButton, isPlaying: Bool) {
        if isPlaying {
            button.backgroundColor = halloweenOrangeHighlight
            let targetPointSize = max(24, min(38, button.bounds.height * 0.35))
            let cfg = UIImage.SymbolConfiguration(pointSize: targetPointSize, weight: .bold, scale: .large)
            if let pauseImg = UIImage(systemName: "pause.fill", withConfiguration: cfg)?
                .withRenderingMode(.alwaysTemplate) {
                button.setImage(pauseImg, for: .normal)
                button.tintColor = .black
                button.imageView?.contentMode = .scaleAspectFit
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)
            }
        } else {
            button.backgroundColor = halloweenOrange
            let originalImage = getOriginalImageName(for: button)
            button.setImage(UIImage(named: originalImage), for: .normal)
            button.tintColor = .black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)
        }
    }

    private func getOriginalImageName(for button: SeekButton) -> String {
        switch button {
        case halloweenButton: return "halloween"
        case exorcistButton: return "cross"
        case shiningButton: return "shining"
        case nightmareButton: return "freddy"
        case fridayButton: return "vorhees"
        case amityvilleButton: return "amityville"
        case unsolvedButton: return "question_mark"
        case xfilesButton: return "magnifying_glass"
        default: return "default_icon"
        }
    }

    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let button = self.audioPlayers.first(where: { $0.value === player })?.key else { return }
            self.updateButtonUI(button, isPlaying: false)
            button.pulsate2(button)
            button.haptic(button)
        }
    }
}
