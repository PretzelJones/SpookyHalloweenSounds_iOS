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
                    button.player = player          // weak link
                    audioPlayers[button] = player   // strong ref
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
 
/*
import UIKit
import AVFoundation

// Map each SeekButton to its AVAudioPlayer
var horrorMovieAudioPlayers: [SeekButton: AVAudioPlayer] = [:]

class HorrorMovieViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets (now SeekButton)
    @IBOutlet weak var halloweenButton: SeekButton!
    @IBOutlet weak var exorcistButton: SeekButton!
    @IBOutlet weak var shiningButton: SeekButton!
    @IBOutlet weak var nightmareButton: SeekButton!
    @IBOutlet weak var fridayButton: SeekButton!
    @IBOutlet weak var amityvilleButton: SeekButton!
    @IBOutlet weak var unsolvedButton: SeekButton!
    @IBOutlet weak var xfilesButton: SeekButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize buttons (inherits your existing helpers)
        halloweenButton.noHighlight(halloweenButton)
        exorcistButton.noHighlight(exorcistButton)
        shiningButton.noHighlight(shiningButton)
        nightmareButton.noHighlight(nightmareButton)
        fridayButton.noHighlight(fridayButton)
        amityvilleButton.noHighlight(amityvilleButton)
        unsolvedButton.noHighlight(unsolvedButton)
        xfilesButton.noHighlight(xfilesButton)

        // Initialize audio players and wire them to SeekButtons
        initializeAudioPlayers()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop all audio when leaving
        for (_, player) in horrorMovieAudioPlayers where player.isPlaying {
            player.stop()
        }
    }

    // MARK: - Setup
    func initializeAudioPlayers() {
        // Use an array of tuples to avoid any optional-key weirdness
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
            var player: AVAudioPlayer?

            if let mp3Path = Bundle.main.path(forResource: sound, ofType: "mp3") {
                do { player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: mp3Path)) }
                catch { print("Error loading MP3 \(sound): \(error)") }
            } else if let wavPath = Bundle.main.path(forResource: sound, ofType: "wav") {
                do { player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: wavPath)) }
                catch { print("Error loading WAV \(sound): \(error)") }
            } else {
                print("File not found: \(sound).mp3/.wav")
            }

            if let player = player {
                player.prepareToPlay()
                player.delegate = self
                player.numberOfLoops = -1

                // Wire player to SeekButton for progress + scrubbing
                button.player = player

                // Keep a map so we can find the button when playback ends
                horrorMovieAudioPlayers[button] = player
            }
        }
    }

    // MARK: - Actions
    @IBAction func soundButtonPressed(_ sender: SeekButton) {
        // Prefer the sender’s wired player
        guard let player = sender.player else { return }

        sender.pulsate(sender)
        sender.haptic(sender)
        sender.showsTouchWhenHighlighted = true

        if player.isPlaying {
            player.pause()
            updateButtonUI(sender, isPlaying: false)
        } else {
            player.play()
            updateButtonUI(sender, isPlaying: true)
        }
    }
    
    func updateButtonUI(_ button: SeekButton, isPlaying: Bool) {
        if isPlaying {
            button.backgroundColor = halloweenOrangeHighlight

            // Make the SF Symbol larger so it matches your old bitmap size
            let targetPointSize = max(24, min(38, button.bounds.height * 0.25))
            let cfg = UIImage.SymbolConfiguration(pointSize: targetPointSize, weight: .bold, scale: .large)

            if let pauseImg = UIImage(systemName: "pause.fill", withConfiguration: cfg)?
                .withRenderingMode(.alwaysTemplate) {
                button.setImage(pauseImg, for: .normal)
                button.tintColor = .black
                button.imageView?.contentMode = .scaleAspectFit
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8) // tweak if needed
            }
        } else {
            button.backgroundColor = halloweenOrange
            let originalImage = getOriginalImageName(for: button)
            button.setImage(UIImage(named: originalImage), for: .normal)  // transparent PNGs
            button.tintColor = .black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)
        }
    }

    func getOriginalImageName(for button: SeekButton) -> String {
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
            if let button = horrorMovieAudioPlayers.first(where: { $0.value === player })?.key {
                self?.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            }
        }
    }
}


// Keeping your helper extension
extension UIButton {
    func setHighlightedEffect() { self.alpha = 0.6 }
    func removeHighlightedEffect() { self.alpha = 1.0 }
}

*/
