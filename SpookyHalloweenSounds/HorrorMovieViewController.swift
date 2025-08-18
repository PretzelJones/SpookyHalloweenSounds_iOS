//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

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

/*
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
    @IBOutlet weak var unsolvedButton: UIButton!
    @IBOutlet weak var xfilesButton: UIButton!

    let halloweenLongPress = UILongPressGestureRecognizer()
    let exorcistLongPress = UILongPressGestureRecognizer()
    let shiningLongPress = UILongPressGestureRecognizer()
    let nightmareLongPress = UILongPressGestureRecognizer()
    let fridayLongPress = UILongPressGestureRecognizer()
    let amityvilleLongPress = UILongPressGestureRecognizer()
    let unsolvedLongPress = UILongPressGestureRecognizer()
    let xfilesLongPress = UILongPressGestureRecognizer()

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
        unsolvedButton.noHighlight(unsolvedButton)
        xfilesButton.noHighlight(xfilesButton)

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
            amityvilleButton: "amityville",
            unsolvedButton: "unsolved_mysteries",
            xfilesButton: "xfiles"
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
                player.numberOfLoops = -1
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
        unsolvedLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        xfilesLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))

        halloweenButton.addGestureRecognizer(halloweenLongPress)
        exorcistButton.addGestureRecognizer(exorcistLongPress)
        shiningButton.addGestureRecognizer(shiningLongPress)
        nightmareButton.addGestureRecognizer(nightmareLongPress)
        fridayButton.addGestureRecognizer(fridayLongPress)
        amityvilleButton.addGestureRecognizer(amityvilleLongPress)
        unsolvedButton.addGestureRecognizer(unsolvedLongPress)
        xfilesButton.addGestureRecognizer(xfilesLongPress)
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
        case unsolvedButton: return "question_mark"
        case xfilesButton: return "magnifying_glass"
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
            case unsolvedLongPress:
                handleReplay(for: unsolvedButton, with: horrorMovieAudioPlayers[unsolvedButton])
            case xfilesLongPress:
                handleReplay(for: xfilesButton, with: horrorMovieAudioPlayers[xfilesButton])
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

*/
