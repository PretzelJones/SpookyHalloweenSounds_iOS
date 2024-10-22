//
//  HiddenViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/6/19.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

// Dictionary to map buttons to their respective AVAudioPlayers
var hiddenAudioPlayers: [UIButton: AVAudioPlayer] = [:]

class HiddenViewController: UIViewController, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var ghostSongButton: UIButton!
    @IBOutlet weak var oldTapeButton: UIButton!
    @IBOutlet weak var criesOfInsanityButton: UIButton!
    @IBOutlet weak var criesHellButton: UIButton!

    let ghostSongLongPress = UILongPressGestureRecognizer()
    let oldTapeLongPress = UILongPressGestureRecognizer()
    let criesOfInsanityLongPress = UILongPressGestureRecognizer()
    let criesHellLongPress = UILongPressGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        //PopupManager.shared.showPopup(inViewController: self)

        // Customize buttons
        ghostSongButton.noHighlight(ghostSongButton)
        oldTapeButton.noHighlight(oldTapeButton)
        criesOfInsanityButton.noHighlight(criesOfInsanityButton)
        criesHellButton.noHighlight(criesHellButton)

        // Initialize audio players
        initializeAudioPlayers()

        // Set up long press gesture recognizers
        setUpGestureRecognizers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop or pause all audio players when navigating away
        for (_, player) in hiddenAudioPlayers {
            if player.isPlaying {
                player.stop()  // Stops the audio and resets the player to the beginning
            }
        }
    }

    // Initialize AVAudioPlayers for each button
    func initializeAudioPlayers() {
        let soundFiles = [
            ghostSongButton: "the_ghost_song",
            oldTapeButton: "the_old_tape",
            criesOfInsanityButton: "chilling_cries",
            criesHellButton: "cries_from_hell"
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
                hiddenAudioPlayers[button] = player
            }
        }
    }

    // Set up gesture recognizers for long press actions
    func setUpGestureRecognizers() {
        ghostSongLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        oldTapeLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        criesOfInsanityLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        criesHellLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))

        ghostSongButton.addGestureRecognizer(ghostSongLongPress)
        oldTapeButton.addGestureRecognizer(oldTapeLongPress)
        criesOfInsanityButton.addGestureRecognizer(criesOfInsanityLongPress)
        criesHellButton.addGestureRecognizer(criesHellLongPress)
    }

    // Handle button presses
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        guard let player = hiddenAudioPlayers[sender] else { return }

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
        case ghostSongButton: return "ghost_song"
        case oldTapeButton: return "old_tape"
        case criesOfInsanityButton: return "dispair"
        case criesHellButton: return "cries_hell"
        default: return "default_icon"
        }
    }

    // Long press handler
    @objc func replayButtonLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            switch gestureRecognizer {
            case ghostSongLongPress:
                handleReplay(for: ghostSongButton, with: hiddenAudioPlayers[ghostSongButton])
            case oldTapeLongPress:
                handleReplay(for: oldTapeButton, with: hiddenAudioPlayers[oldTapeButton])
            case criesOfInsanityLongPress:
                handleReplay(for: criesOfInsanityButton, with: hiddenAudioPlayers[criesOfInsanityButton])
            case criesHellLongPress:
                handleReplay(for: criesHellButton, with: hiddenAudioPlayers[criesHellButton])
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
            if let button = hiddenAudioPlayers.first(where: { $0.value === player })?.key {
                self?.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            }
        }
    }
}
