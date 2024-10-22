//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/5/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

// Dictionary to map buttons to their respective AVAudioPlayers
var longMixAudioPlayers: [UIButton: AVAudioPlayer] = [:]

class LongMixViewController: UIViewController, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var ultraTerrorButton: UIButton!
    @IBOutlet weak var hauntedHouseButton: UIButton!
    @IBOutlet weak var spookySoundsButton: UIButton!
    @IBOutlet weak var spaceTerrorButton: UIButton!
    @IBOutlet weak var dontLetThemInButton: UIButton!
    
    let ultraTerrorLongPress = UILongPressGestureRecognizer()
    let hauntedHouseLongPress = UILongPressGestureRecognizer()
    let spookySoundsLongPress = UILongPressGestureRecognizer()
    let spaceTerrorLongPress = UILongPressGestureRecognizer()
    let dontLetThemInLongPress = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //PopupManager.shared.showPopup(inViewController: self)

        // Customize buttons
        ultraTerrorButton.noHighlight(ultraTerrorButton)
        hauntedHouseButton.noHighlight(hauntedHouseButton)
        spookySoundsButton.noHighlight(spookySoundsButton)
        spaceTerrorButton.noHighlight(spaceTerrorButton)
        dontLetThemInButton.noHighlight(dontLetThemInButton)

        // Initialize audio players
        initializeAudioPlayers()
        
        // Set up long press gesture recognizers
        setUpGestureRecognizers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop or pause all audio players when navigating away
        for (_, player) in longMixAudioPlayers {
            if player.isPlaying {
                player.stop()  // Stops the audio and resets the player to the beginning
            }
        }
    }

    // Initialize AVAudioPlayers for each button
    func initializeAudioPlayers() {
        let soundFiles = [
            ultraTerrorButton: "ultra_terror",
            hauntedHouseButton: "haunted_house",
            spookySoundsButton: "long_mix",
            spaceTerrorButton: "space_terror",
            dontLetThemInButton: "dont_let_in"
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
                player.delegate = self // Assign delegate to self
                longMixAudioPlayers[button] = player
            }
        }
    }

    // Set up gesture recognizers for long press actions
    func setUpGestureRecognizers() {
        ultraTerrorLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        hauntedHouseLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        spookySoundsLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        spaceTerrorLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        dontLetThemInLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))

        ultraTerrorButton.addGestureRecognizer(ultraTerrorLongPress)
        hauntedHouseButton.addGestureRecognizer(hauntedHouseLongPress)
        spookySoundsButton.addGestureRecognizer(spookySoundsLongPress)
        spaceTerrorButton.addGestureRecognizer(spaceTerrorLongPress)
        dontLetThemInButton.addGestureRecognizer(dontLetThemInLongPress)
    }

    // Handle button presses
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        guard let player = longMixAudioPlayers[sender] else { return }

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
        case ultraTerrorButton: return "ultra_terror"
        case hauntedHouseButton: return "haunted_circus"
        case spookySoundsButton: return "spooky_sounds"
        case spaceTerrorButton: return "space_terrors"
        case dontLetThemInButton: return "key"
        default: return "default_icon"
        }
    }

    // Long press handler
    @objc func replayButtonLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            switch gestureRecognizer {
            case ultraTerrorLongPress:
                handleReplay(for: ultraTerrorButton, with: longMixAudioPlayers[ultraTerrorButton])
            case hauntedHouseLongPress:
                handleReplay(for: hauntedHouseButton, with: longMixAudioPlayers[hauntedHouseButton])
            case spookySoundsLongPress:
                handleReplay(for: spookySoundsButton, with: longMixAudioPlayers[spookySoundsButton])
            case spaceTerrorLongPress:
                handleReplay(for: spaceTerrorButton, with: longMixAudioPlayers[spaceTerrorButton])
            case dontLetThemInLongPress:
                handleReplay(for: dontLetThemInButton, with: longMixAudioPlayers[dontLetThemInButton])
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
            guard let strongSelf = self else { return } // Safely unwrap self
            if let button = longMixAudioPlayers.first(where: { $0.value === player })?.key {
                strongSelf.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            }
        }
    }
}
