//
//  KidsViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/14/25.
//

import UIKit
import AVFoundation

final class PartySongsViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var ghostbustersButton: SeekButton!
    @IBOutlet weak var spellonyouButton: SeekButton!
    @IBOutlet weak var thisishalloweenButton: SeekButton!
    @IBOutlet weak var littleshopofhorrorsButton: SeekButton!
    @IBOutlet weak var adamsfamilyButton: SeekButton!
    @IBOutlet weak var mostermashButton: SeekButton!
    @IBOutlet weak var spookyscaryskeletonsButton: SeekButton!
    
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

        [ghostbustersButton,
         spellonyouButton,
         thisishalloweenButton,
         littleshopofhorrorsButton,
         adamsfamilyButton,
         mostermashButton,
         spookyscaryskeletonsButton].forEach { $0?.noHighlight($0!) }

        initializeAudioPlayers()
    }
    
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
            (ghostbustersButton, "ghostbusters"),
            (spellonyouButton, "i_put_a_spell_on_you"),
            (thisishalloweenButton, "this_is_halloween"),
            (littleshopofhorrorsButton, "little_shop_of_horrors"),
            (adamsfamilyButton, "adams_family"),
            (mostermashButton, "monster_mash"),
            (spookyscaryskeletonsButton, "spooky_scary_skeletons")
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
        case ghostbustersButton:          return "ghostbusters"
        case spellonyouButton:            return "spell_on_you"   // corrected from "hocus_pocus"
        case thisishalloweenButton:       return "jack_skellington"
        case littleshopofhorrorsButton:   return "audrey"
        case adamsfamilyButton:           return "creaky_door"
        case mostermashButton:            return "monster_mash"
        case spookyscaryskeletonsButton:  return "spooky_skeletons"
        default:                          return "default_icon"
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
var partyAudioPlayers: [SeekButton: AVAudioPlayer] = [:]

final class PartySongsViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Outlets (SeekButton)
    @IBOutlet weak var ghostbustersButton: SeekButton!
    @IBOutlet weak var spellonyouButton: SeekButton!
    @IBOutlet weak var thisishalloweenButton: SeekButton!
    @IBOutlet weak var littleshopofhorrorsButton: SeekButton!
    @IBOutlet weak var adamsfamilyButton: SeekButton!
    @IBOutlet weak var mostermashButton: SeekButton!
    @IBOutlet weak var spookyscaryskeletonsButton: SeekButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customFont = UIFont(name: "Creepster-Regular", size: 26) {
            navigationController?.navigationBar.titleTextAttributes = [
                .font: customFont,
                .foregroundColor: halloweenOrange
            ]
        }

        ghostbustersButton.noHighlight(ghostbustersButton)
        spellonyouButton.noHighlight(spellonyouButton)
        thisishalloweenButton.noHighlight(thisishalloweenButton)
        littleshopofhorrorsButton.noHighlight(littleshopofhorrorsButton)
        adamsfamilyButton.noHighlight(adamsfamilyButton)
        mostermashButton.noHighlight(mostermashButton)
        spookyscaryskeletonsButton.noHighlight(spookyscaryskeletonsButton)

        // Initialize audio players and wire them to SeekButtons
        initializeAudioPlayers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNewFeatureOnce()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for (_, player) in partyAudioPlayers where player.isPlaying {
            player.stop()
        }
    }

    // MARK: - Setup
    private func initializeAudioPlayers() {
        let items: [(SeekButton, String)] = [
            (ghostbustersButton, "ghostbusters"),
            (spellonyouButton, "i_put_a_spell_on_you"),
            (thisishalloweenButton, "this_is_halloween"),
            (littleshopofhorrorsButton, "little_shop_of_horrors"),
            (adamsfamilyButton, "adams_family"),
            (mostermashButton, "monster_mash"),
            (spookyscaryskeletonsButton, "spooky_scary_skeletons")
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
                partyAudioPlayers[button] = player
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
            button.setImage(UIImage(named: originalImage), for: .normal)
            button.tintColor = .black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 8)
        }
    }

    func getOriginalImageName(for button: SeekButton) -> String {
        switch button {
        case ghostbustersButton:          return "ghostbusters"
        case spellonyouButton:            return "hocus_pocus"
        case thisishalloweenButton:       return "jack_skellington"
        case littleshopofhorrorsButton:   return "audrey"
        case adamsfamilyButton:           return "creaky_door"
        case mostermashButton:            return "monster_mash"
        case spookyscaryskeletonsButton:  return "spooky_skeletons"
        default:                          return "default_icon"
        }
    }

    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            if let button = partyAudioPlayers.first(where: { $0.value === player })?.key {
                self?.updateButtonUI(button, isPlaying: false)
                button.pulsate2(button)
                button.haptic(button)
            }
        }
    }
}

*/
