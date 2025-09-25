//
//  ViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/29/18.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation
import StoreKit

// Dictionary to map buttons to their respective AVAudioPlayers
var audioPlayers: [UIButton: AVAudioPlayer] = [:]

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //@IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var witchCackleButton: UIButton!
    @IBOutlet weak var blackCatButton: UIButton!
    @IBOutlet weak var creepyLaughButton: UIButton!
    @IBOutlet weak var creakyDoorButton: UIButton!
    @IBOutlet weak var horrorAmbianceButton: UIButton!
    @IBOutlet weak var monsterGrowlButton: UIButton!
    @IBOutlet weak var monsterWalkingButton: UIButton!
    @IBOutlet weak var spookyChainsButton: UIButton!
    @IBOutlet weak var thunderStormButton: UIButton!
    @IBOutlet weak var scaryScreamButton: UIButton!
    @IBOutlet weak var zombieGroanButton: UIButton!
    @IBOutlet weak var ghostBooButton: UIButton!
    @IBOutlet weak var werewolfHowlButton: UIButton!
    @IBOutlet weak var poltergeistVoiceButton: UIButton!
    @IBOutlet weak var zombieCallButton: UIButton!
    @IBOutlet weak var catScreamButton: UIButton!
    @IBOutlet weak var wraithWailButton: UIButton!
    @IBOutlet weak var spookyOwlButton: UIButton!
    @IBOutlet weak var chainedGhoulButton: UIButton!
    @IBOutlet weak var terrifiedScreamButton: UIButton!
    @IBOutlet weak var hauntedOrganButton: UIButton!
    @IBOutlet weak var scarecrowButton: UIButton!
    @IBOutlet weak var blowingWindButton: UIButton!
    @IBOutlet weak var ghostlyWhisperButton: UIButton!
    @IBOutlet weak var draculaLaughButton: UIButton!
    @IBOutlet weak var wolfCryButton: UIButton!
    @IBOutlet weak var knockKnockButton: UIButton!
    @IBOutlet weak var igorGrumbleButton: UIButton!
    @IBOutlet weak var horrorMovieButton: UIButton!
    @IBOutlet weak var warningBellsButton: UIButton!
    @IBOutlet weak var painfulMoanButton: UIButton!
    @IBOutlet weak var witchesCauldronButton: UIButton!
    @IBOutlet weak var ghostlyChildrenButton: UIButton!
    @IBOutlet weak var hauntedSwampButton: UIButton!
    @IBOutlet weak var torturedSoulsButton: UIButton!
    @IBOutlet weak var chillingHornButton: UIButton!
    
    @IBOutlet weak var loopingMixButton: UIButton!
    @IBOutlet weak var horrorThemeButton: UIButton!
    
    var countdownTimer: Timer?
    let countdownManager = CountdownManager()
    
    // viewDidLoad method, override to customize your ViewController behavior
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Countdown
        //daysLabel.text = countdownManager.getCountdownText()
        startCountdownTimer()
        
        setupNavigationTitleWithCountdown()
        
        // Initialize all sounds with helper function
        initializeAudioPlayers()
        
        // Set up back button customization
        //setupBackButton()
        
        let key = "popupVersionShown"
        let stored = UserDefaults.standard.string(forKey: key) ?? "none"
        print("[UD TEST] Before write:", stored)

        UserDefaults.standard.set("test_value", forKey: key)
        UserDefaults.standard.synchronize()

        let updated = UserDefaults.standard.string(forKey: key) ?? "none"
        print("[UD TEST] After write:", updated)
    }
    
    // Helper function to initialize AVAudioPlayers and map them to buttons
    func initializeAudioPlayers() {
        let soundFiles = [
            witchCackleButton: "witch_laugh",
            blackCatButton: "black_cat",
            creepyLaughButton: "evil_man",
            creakyDoorButton: "creaky_door",
            horrorAmbianceButton: "horror_ambience",
            monsterGrowlButton: "monster_growl",
            monsterWalkingButton: "monster_walking",
            spookyChainsButton: "spooky_chains",
            thunderStormButton: "thunder",
            scaryScreamButton: "scary_scream",
            zombieGroanButton: "zombie",
            ghostBooButton: "ghost_boo",
            werewolfHowlButton: "werewolf_howl",
            poltergeistVoiceButton: "poltergeist_voice",
            zombieCallButton: "zombie_come",
            catScreamButton: "cat_scream",
            wraithWailButton: "wraith_wail",
            spookyOwlButton: "spooky_owl",
            chainedGhoulButton: "chained_ghoul",
            terrifiedScreamButton: "terrified_scream",
            hauntedOrganButton: "haunted_organ",
            scarecrowButton: "scarecrow",
            blowingWindButton: "blowing_wind",
            ghostlyWhisperButton: "ghostly_whisper",
            draculaLaughButton: "dracula_laugh",
            wolfCryButton: "wolf_cry",
            knockKnockButton: "knock_knock",
            igorGrumbleButton: "igor_grumble",
            horrorMovieButton: "horror_film",
            warningBellsButton: "warning_bells",
            painfulMoanButton: "painful_moan",
            witchesCauldronButton: "bubbles",
            ghostlyChildrenButton: "scary_nursery",
            hauntedSwampButton: "haunted_swamp",
            torturedSoulsButton: "tortured_souls",
            chillingHornButton: "chilling_horn"
        ]
        
        for (button, sound) in soundFiles {
            guard let button = button else { continue }  // Safely unwrap button
            
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
                player.delegate = self // <-- Ensure delegate is set here
                audioPlayers[button] = player
            }
        }
    }
    
    // Single handler for sound button interactions
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        guard let player = audioPlayers[sender] else { return }
        
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
    
    // Single handler for loopingMix and horrorTheme buttons
    @IBAction func nonAudioButtonPressed(_ sender: UIButton) {
        sender.pulsate(sender)
        sender.haptic(sender)
    }
    
    // Helper function to update button UI based on play/pause state
    func updateButtonUI(_ button: UIButton, isPlaying: Bool) {
        print("Updating button UI for: \(button) | isPlaying: \(isPlaying)")
        if isPlaying {
            button.backgroundColor = halloweenOrangeHighlight
            button.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            button.backgroundColor = halloweenOrange
            let originalImage = getOriginalImageName(for: button)
            print("Setting image for button to: \(originalImage)")
            button.setImage(UIImage(named: originalImage), for: .normal)
        }
    }
    
    func getOriginalImageName(for button: UIButton) -> String {
        switch button {
        case witchCackleButton: return "witch"
        case blackCatButton: return "black_cat"
        case creepyLaughButton: return "evil_man"
        case creakyDoorButton: return "creaky_door"
        case horrorAmbianceButton: return "spider"
        case monsterGrowlButton: return "monster_growl"
        case monsterWalkingButton: return "monster_walking"
        case spookyChainsButton: return "chains"
        case thunderStormButton: return "thunder"
        case scaryScreamButton: return "scream"
        case zombieGroanButton: return "zombie"
        case ghostBooButton: return "ghost_boo"
        case werewolfHowlButton: return "werewolf"
        case poltergeistVoiceButton: return "poltergeist_tv"
        case zombieCallButton: return "zombie_call"
        case catScreamButton: return "cat_scream"
        case wraithWailButton: return "wraith_wail"
        case spookyOwlButton: return "spooky_owl"
        case chainedGhoulButton: return "chained_ghoul"
        case terrifiedScreamButton: return "terrified_scream"
        case hauntedOrganButton: return "haunted_organ"
        case scarecrowButton: return "scarecrow"
        case blowingWindButton: return "blowing_wind"
        case ghostlyWhisperButton: return "ghostly_whisper"
        case draculaLaughButton: return "dracula_laugh"
        case wolfCryButton: return "wolf"
        case knockKnockButton: return "knock"
        case igorGrumbleButton: return "igor"
        case horrorMovieButton: return "film"
        case warningBellsButton: return "warning_bells"
        case painfulMoanButton: return "grave_stone"
        case witchesCauldronButton: return "witches_cauldron"
        case ghostlyChildrenButton: return "ghostly_children"
        case hauntedSwampButton: return "haunted_swamp"
        case torturedSoulsButton: return "tortured_souls"
        case chillingHornButton: return "alien"
        default: return "default_icon" // Fallback in case a button is not matched
        }
    }
    
    // Start countdown timer
    func startCountdownTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateCountdownText), userInfo: nil, repeats: true)
    }
    
    // Helper function to set the daysLabel as the titleView
    func setupNavigationTitleWithCountdown() {
        // Create the bats image view
        let batsImage = UIImage(named: "bats")
        let batsImageView = UIImageView(image: batsImage)
        batsImageView.contentMode = .scaleAspectFit
        batsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view to hold the bats image
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(batsImageView)
        
        // Set Auto Layout constraints for the bats image to ensure proper scaling within container
        NSLayoutConstraint.activate([
            batsImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            batsImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            batsImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            batsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Set a specific height and width for the container view relative to the navigation bar height
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 50),  // Set a dynamic width; increase this to make it larger
            containerView.heightAnchor.constraint(equalToConstant: 40)  // Set height based on navigation bar height
        ])
        
        // Create a UIBarButtonItem with the container view holding the bats image
        let imageItem = UIBarButtonItem(customView: containerView)
        
        // Create a negative spacer to move the image to the far left
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -15  // Adjust this value to fine-tune the alignment
        
        // Set the left bar button items to include the negative spacer and the image item
        self.navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
        
        // Create the countdown label for the title view
        
        let countdownLabel = UILabel()
        // Add these lines to enable text resizing
        countdownLabel.adjustsFontSizeToFitWidth = true
        countdownLabel.minimumScaleFactor = 0.5  // Set the minimum scale factor to 50% of original size
        countdownLabel.lineBreakMode = .byTruncatingTail  // Ensure text truncates with an ellipsis if it gets too small
        countdownLabel.text = countdownManager.getCountdownText()  // Get the countdown text directly from countdownManager
        countdownLabel.font = UIFont(name: "Creepster", size: 28)
        countdownLabel.textColor = halloweenOrange
        countdownLabel.textAlignment = .center
        countdownLabel.sizeToFit()
        
        // Set the countdown label as the titleView
        self.navigationItem.titleView = countdownLabel
    }
    
    @objc func updateCountdownText() {
        // Update the countdown label in the navigation bar title view
        if let countdownLabel = self.navigationItem.titleView as? UILabel {
            countdownLabel.text = countdownManager.getCountdownText()
        }
    }
    /*
     @objc func updateCountdownText() {
     // Update both the main label and the title view label
     let countdownText = countdownManager.getCountdownText()
     //daysLabel.text = countdownText
     if let containerView = self.navigationItem.titleView as? UIView,
     let stackView = containerView.subviews.first as? UIStackView,
     let countdownLabel = stackView.arrangedSubviews.last as? UILabel {
     countdownLabel.text = countdownText
     }
     } */
    
    /*
     @objc func updateCountdownText() {
     daysLabel.text = countdownManager.getCountdownText()
     } */
    

    /*
    // Customize back button
    func setupBackButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
        
        let arrowImage = UIImage(named: "left_arrow")
        self.navigationController?.navigationBar.backIndicatorImage = arrowImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = arrowImage
        self.navigationController?.navigationBar.backItem?.title = "Custom"
    }
    */
    // Audio player finished playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            if let button = audioPlayers.first(where: { $0.value === player })?.key {
                print("Audio finished for button: \(button)")
                // Reset the button's UI to the original state
                self.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            } else {
                print("Could not find button for finished audio player")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop the countdown timer to avoid memory leaks
        countdownTimer?.invalidate()
        
        // Stop and release all audio players when navigating away
        for (button, player) in audioPlayers {
            if player.isPlaying {
                player.stop()  // Stops the audio and resets the player to the beginning
            }
            // Reset the button to its original state
            updateButtonUI(button, isPlaying: false)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCountdownTimer()
        SKStoreReviewController.requestReview()
    }
}

