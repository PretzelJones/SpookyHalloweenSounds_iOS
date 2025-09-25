//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/5/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

final class LongMixViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var ultraTerrorButton: SeekButton!
    @IBOutlet weak var hauntedHouseButton: SeekButton!
    @IBOutlet weak var spookySoundsButton: SeekButton!
    @IBOutlet weak var spaceTerrorButton: SeekButton!
    @IBOutlet weak var dontLetThemInButton: SeekButton!

    // MARK: - Strong refs
    private var audioPlayers: [SeekButton: AVAudioPlayer] = [:]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customFont = UIFont(name: "Creepster-Regular", size: 26) {
            navigationController?.navigationBar.titleTextAttributes = [
                .font: customFont,
                .foregroundColor: halloweenOrange
            ]
        }

        [ultraTerrorButton,
         hauntedHouseButton,
         spookySoundsButton,
         spaceTerrorButton,
         dontLetThemInButton].forEach { $0?.noHighlight($0!) }

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
            (ultraTerrorButton, "ultra_terror"),
            (hauntedHouseButton, "haunted_house"),
            (spookySoundsButton, "long_mix"),
            (spaceTerrorButton, "space_terror"),
            (dontLetThemInButton, "dont_let_in")
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
        case ultraTerrorButton:     return "ultra_terror"
        case hauntedHouseButton:    return "haunted_house"   // corrected from circus
        case spookySoundsButton:    return "spooky_sounds"
        case spaceTerrorButton:     return "space_terror"    // corrected singular
        case dontLetThemInButton:   return "key"
        default:                    return "default_icon"
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

/*
import UIKit
import AVFoundation

// Map each SeekButton to its AVAudioPlayer
var longMixAudioPlayers: [SeekButton: AVAudioPlayer] = [:]

final class LongMixViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets (SeekButton)
    @IBOutlet weak var ultraTerrorButton: SeekButton!
    @IBOutlet weak var hauntedHouseButton: SeekButton!
    @IBOutlet weak var spookySoundsButton: SeekButton!
    @IBOutlet weak var spaceTerrorButton: SeekButton!
    @IBOutlet weak var dontLetThemInButton: SeekButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customFont = UIFont(name: "Creepster-Regular", size: 26) {
            navigationController?.navigationBar.titleTextAttributes = [
                .font: customFont,
                .foregroundColor: halloweenOrange
            ]
        }

        // Your existing styling helpers
        ultraTerrorButton.noHighlight(ultraTerrorButton)
        hauntedHouseButton.noHighlight(hauntedHouseButton)
        spookySoundsButton.noHighlight(spookySoundsButton)
        spaceTerrorButton.noHighlight(spaceTerrorButton)
        dontLetThemInButton.noHighlight(dontLetThemInButton)

        // Initialize audio players and wire them to SeekButtons
        initializeAudioPlayers()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for (_, player) in longMixAudioPlayers where player.isPlaying { player.stop() }
    }

    // MARK: - Setup
    private func initializeAudioPlayers() {
        let items: [(SeekButton, String)] = [
            (ultraTerrorButton, "ultra_terror"),
            (hauntedHouseButton, "haunted_house"),
            (spookySoundsButton, "long_mix"),
            (spaceTerrorButton, "space_terror"),
            (dontLetThemInButton, "dont_let_in")
        ]

        for (button, sound) in items {
            var player: AVAudioPlayer?

            if let path = Bundle.main.path(forResource: sound, ofType: "mp3") ??
                          Bundle.main.path(forResource: sound, ofType: "wav") {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                } catch {
                    print("Error loading \(sound): \(error)")
                }
            } else {
                print("File not found: \(sound).mp3/.wav")
            }

            if let player = player {
                player.prepareToPlay()
                player.delegate = self
                player.numberOfLoops = -1

                button.player = player
                longMixAudioPlayers[button] = player
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
    func updateButtonUI(_ button: SeekButton, isPlaying: Bool) {
        if isPlaying {
            button.backgroundColor = halloweenOrangeHighlight

            // Size the SF Symbol pause icon (tweak multiplier to taste)
            let targetPointSize = max(24, min(38, button.bounds.height * 0.45))
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
            button.setImage(UIImage(named: originalImage), for: .normal) // transparent PNGs
            button.tintColor = .black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)
        }
    }

    func getOriginalImageName(for button: SeekButton) -> String {
        switch button {
        case ultraTerrorButton:     return "ultra_terror"
        case hauntedHouseButton:    return "haunted_circus"   // (image asset name as in your VC)
        case spookySoundsButton:    return "spooky_sounds"
        case spaceTerrorButton:     return "space_terrors"
        case dontLetThemInButton:   return "key"
        default:                    return "default_icon"
        }
    }

    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            if let button = longMixAudioPlayers.first(where: { $0.value === player })?.key {
                self?.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            }
        }
    }
}
*/
