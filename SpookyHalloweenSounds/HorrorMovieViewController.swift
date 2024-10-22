//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

// Dictionary to map buttons to their respective AVAudioPlayers
var horrorMovieAudioPlayers: [UIButton: AVAudioPlayer] = [:]

class HorrorMovieViewController: UIViewController, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var halloweenButton: UIButton!
    @IBOutlet weak var exorcistButton: UIButton!
    @IBOutlet weak var shiningButton: UIButton!
    @IBOutlet weak var nightmareButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var amityvilleButton: UIButton!

    let halloweenLongPress = UILongPressGestureRecognizer()
    let exorcistLongPress = UILongPressGestureRecognizer()
    let shiningLongPress = UILongPressGestureRecognizer()
    let nightmareLongPress = UILongPressGestureRecognizer()
    let fridayLongPress = UILongPressGestureRecognizer()
    let amityvilleLongPress = UILongPressGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        //PopupManager.shared.showPopup(inViewController: self)

        // Customize buttons
        halloweenButton.noHighlight(halloweenButton)
        exorcistButton.noHighlight(exorcistButton)
        shiningButton.noHighlight(shiningButton)
        nightmareButton.noHighlight(nightmareButton)
        fridayButton.noHighlight(fridayButton)
        amityvilleButton.noHighlight(amityvilleButton)

        // Initialize audio players
        initializeAudioPlayers()

        // Set up long press gesture recognizers
        setUpGestureRecognizers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop all audio players when navigating away
        for (_, player) in horrorMovieAudioPlayers {
            if player.isPlaying {
                player.stop()  // Stops the audio and resets the player to the beginning
            }
        }
    }

    // Initialize AVAudioPlayers for each button
    func initializeAudioPlayers() {
        let soundFiles = [
            halloweenButton: "halloween",
            exorcistButton: "exorcist",
            shiningButton: "shining",
            nightmareButton: "elm_street",
            fridayButton: "vorhees",
            amityvilleButton: "amityville"
        ]

        for (button, sound) in soundFiles {
            guard let button = button else { continue }  // Safely unwrap the button

            var player: AVAudioPlayer?

            // Try to load as mp3 first, if not found, try wav
            if let mp3Path = Bundle.main.path(forResource: sound, ofType: "mp3") {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: mp3Path))
                } catch {
                    print("Error loading MP3 file \(sound): \(error)")
                }
            } else if let wavPath = Bundle.main.path(forResource: sound, ofType: "wav") {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: wavPath))
                } catch {
                    print("Error loading WAV file \(sound): \(error)")
                }
            } else {
                print("File not found: \(sound) as either mp3 or wav")
            }

            // If the player is successfully created, store it in the dictionary
            if let player = player {
                player.prepareToPlay()
                player.delegate = self
                horrorMovieAudioPlayers[button] = player
            }
        }
    }

    // Set up gesture recognizers for long press actions
    func setUpGestureRecognizers() {
        halloweenLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        exorcistLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        shiningLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        nightmareLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        fridayLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        amityvilleLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))

        halloweenButton.addGestureRecognizer(halloweenLongPress)
        exorcistButton.addGestureRecognizer(exorcistLongPress)
        shiningButton.addGestureRecognizer(shiningLongPress)
        nightmareButton.addGestureRecognizer(nightmareLongPress)
        fridayButton.addGestureRecognizer(fridayLongPress)
        amityvilleButton.addGestureRecognizer(amityvilleLongPress)
    }

    // Handle button presses
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        guard let player = horrorMovieAudioPlayers[sender] else { return }

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

    // Update button UI when audio plays or pauses
    func updateButtonUI(_ button: UIButton, isPlaying: Bool) {
        if isPlaying {
            button.backgroundColor = halloweenOrangeHighlight
            button.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            button.backgroundColor = halloweenOrange
            let originalImage = getOriginalImageName(for: button)
            button.setImage(UIImage(named: originalImage), for: .normal)
        }
    }

    // Return the original image for each button
    func getOriginalImageName(for button: UIButton) -> String {
        switch button {
        case halloweenButton: return "halloween"
        case exorcistButton: return "cross"
        case shiningButton: return "shining"
        case nightmareButton: return "freddy"
        case fridayButton: return "vorhees"
        case amityvilleButton: return "amityville"
        default: return "default_icon"
        }
    }

    // Long press handler
    @objc func replayButtonLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            switch gestureRecognizer {
            case halloweenLongPress:
                handleReplay(for: halloweenButton, with: horrorMovieAudioPlayers[halloweenButton])
            case exorcistLongPress:
                handleReplay(for: exorcistButton, with: horrorMovieAudioPlayers[exorcistButton])
            case shiningLongPress:
                handleReplay(for: shiningButton, with: horrorMovieAudioPlayers[shiningButton])
            case nightmareLongPress:
                handleReplay(for: nightmareButton, with: horrorMovieAudioPlayers[nightmareButton])
            case fridayLongPress:
                handleReplay(for: fridayButton, with: horrorMovieAudioPlayers[fridayButton])
            case amityvilleLongPress:
                handleReplay(for: amityvilleButton, with: horrorMovieAudioPlayers[amityvilleButton])
            default:
                break
            }
        }
    }

    // Replay logic for long press
    func handleReplay(for button: UIButton, with player: AVAudioPlayer?) {
        guard let player = player else { return }
        player.currentTime = 0 // Restart the audio
        player.play()
        updateButtonUI(button, isPlaying: true) // Update button state to show it's playing
    }

    // Audio player finished playing
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

extension UIButton {
    func setHighlightedEffect() {
        self.alpha = 0.6  // Dim the button to simulate highlight
    }

    func removeHighlightedEffect() {
        self.alpha = 1.0  // Restore the button's original appearance
    }
}
