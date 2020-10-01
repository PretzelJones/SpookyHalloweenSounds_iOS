//
//  HiddenViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/6/19.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class HiddenViewController: UIViewController, AVAudioPlayerDelegate {
    
    var ghostSongPlayer: AVAudioPlayer?
    var oldTapePlayer: AVAudioPlayer?
    var criesOfInsanityPlayer: AVAudioPlayer?
    var criesHellPlayer: AVAudioPlayer?
    
    @IBOutlet weak var ghostSongButton: UIButton!
    @IBOutlet weak var oldTapeButton: UIButton!
    @IBOutlet weak var criesOfInsanityButton: UIButton!
    @IBOutlet weak var criesHellButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ghostSongButton.noHighlight(ghostSongButton)
        oldTapeButton.noHighlight(oldTapeButton)
        criesHellButton.noHighlight(criesHellButton)
        criesOfInsanityButton.noHighlight(criesOfInsanityButton)
        
        do {
            
            ghostSongPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "the_ghost_song", ofType: "mp3")!))
            ghostSongPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            oldTapePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "the_old_tape", ofType: "mp3")!))
            oldTapePlayer?.prepareToPlay()
        }
        catch {
            print(error)        }
        
        
        do {
            
            criesOfInsanityPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chilling_cries", ofType: "mp3")!))
            criesOfInsanityPlayer?.prepareToPlay()
        }
        catch {
            print(error)        }
        
        do {
            
            criesHellPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "cries_from_hell", ofType: "mp3")!))
            criesHellPlayer?.prepareToPlay()
        }
        catch {
            print(error)        }
    }
    
    @IBAction func ghostSongPlay(_ sender: Any) {
        
        ghostSongButton.pulsate(ghostSongButton)
        ghostSongButton.haptic(ghostSongButton)
        ghostSongButton.showsTouchWhenHighlighted = true
        
        if (ghostSongPlayer!.isPlaying)
        {
            ghostSongPlayer?.delegate = self
            ghostSongPlayer!.pause();
            ghostSongButton.backgroundColor = halloweenOrange
            ghostSongButton.setImage(UIImage(named: "ghost_song"), for: .normal)
        }
        else
        {
            ghostSongPlayer?.delegate = self
            ghostSongPlayer!.play();
            ghostSongPlayer!.numberOfLoops = -1
            ghostSongButton.backgroundColor = halloweenOrangeHighlight
            ghostSongButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func oldTapePlay(_ sender: Any) {
        
        oldTapeButton.pulsate(oldTapeButton)
        oldTapeButton.haptic(oldTapeButton)
        oldTapeButton.showsTouchWhenHighlighted = true
        
        if (oldTapePlayer!.isPlaying)
        {
            oldTapePlayer?.delegate = self
            oldTapePlayer!.pause();
            oldTapeButton.backgroundColor = halloweenOrange
            oldTapeButton.setImage(UIImage(named: "old_tape"), for: .normal)
        }
        else
        {
            oldTapePlayer?.delegate = self
            oldTapePlayer!.play();
            oldTapePlayer!.numberOfLoops = -1
            oldTapeButton.backgroundColor = halloweenOrangeHighlight
            oldTapeButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func criesOfInsanityPlay(_ sender: Any) {
        
        criesOfInsanityButton.pulsate(criesOfInsanityButton)
        criesOfInsanityButton.haptic(criesOfInsanityButton)
        criesOfInsanityButton.showsTouchWhenHighlighted = true
        
        if (criesOfInsanityPlayer!.isPlaying)
        {
            criesOfInsanityPlayer?.delegate = self
            criesOfInsanityPlayer!.pause();
            criesOfInsanityButton.backgroundColor = halloweenOrange
            criesOfInsanityButton.setImage(UIImage(named: "dispair"), for: .normal)
        }
        else
        {
            criesOfInsanityPlayer?.delegate = self
            criesOfInsanityPlayer!.play();
            criesOfInsanityPlayer!.numberOfLoops = -1
            criesOfInsanityButton.backgroundColor = halloweenOrangeHighlight
            criesOfInsanityButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func criesHellPlay(_ sender: Any) {
        
        criesHellButton.pulsate(criesHellButton)
        criesHellButton.haptic(criesHellButton)
        criesHellButton.showsTouchWhenHighlighted = true
        
        if (criesHellPlayer!.isPlaying)
        {
            criesHellPlayer?.delegate = self
            criesHellPlayer!.pause();
            criesHellButton.backgroundColor = halloweenOrange
            criesHellButton.setImage(UIImage(named: "cries_hell"), for: .normal)
        }
        else
        {
            criesHellPlayer?.delegate = self
            criesHellPlayer!.play();
            criesHellPlayer!.numberOfLoops = -1
            criesHellButton.backgroundColor = halloweenOrangeHighlight
            criesHellButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === ghostSongPlayer) {
            ghostSongButton.backgroundColor = halloweenOrange
            ghostSongButton.setImage(UIImage(named: "ghost_song"), for: .normal)
            ghostSongButton.pulsate2(ghostSongButton)
        } else if (player === oldTapePlayer) {
            oldTapeButton.backgroundColor = halloweenOrange
            oldTapeButton.setImage(UIImage(named: "old_tape"), for: .normal)
            oldTapeButton.pulsate2(oldTapeButton)
        } else if (player === criesOfInsanityPlayer) {
            criesOfInsanityButton.backgroundColor = halloweenOrange
            criesOfInsanityButton.setImage(UIImage(named: "dispair"), for: .normal)
            criesOfInsanityButton.pulsate2(criesOfInsanityButton)
        } else if (player === criesHellPlayer) {
            criesHellButton.backgroundColor = halloweenOrange
            criesHellButton.setImage(UIImage(named: "cries_hell"), for: .normal)
            criesHellButton.pulsate2(criesHellButton)
        }
    }
    
}
