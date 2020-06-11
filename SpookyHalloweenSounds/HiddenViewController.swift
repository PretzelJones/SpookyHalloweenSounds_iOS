//
//  HiddenViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/6/19.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class HiddenViewController: UIViewController {
    
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
        
        ghostSongButton.startAnimatingPressActions()
        oldTapeButton.startAnimatingPressActions()
        criesOfInsanityButton.startAnimatingPressActions()
        criesHellButton.startAnimatingPressActions()
        
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
            print(error)
            
        }
        
        
        do {
            
            criesOfInsanityPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chilling_cries", ofType: "mp3")!))
            criesOfInsanityPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            criesHellPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "cries_from_hell", ofType: "mp3")!))
            criesHellPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//    }
    
    @IBAction func ghostSongPlay(_ sender: Any) {
        
        if (ghostSongPlayer!.isPlaying)
        {
            ghostSongPlayer!.pause();
            ghostSongButton.backgroundColor = halloweenOrange
            ghostSongButton.setTitleColor(UIColor.black, for: .normal)
            ghostSongButton.setImage(UIImage(named: "ghost_song"), for: .normal)
        }
        else
        {
            ghostSongPlayer!.play();
            ghostSongButton.backgroundColor = halloweenOrangeHighlight
            ghostSongButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func oldTapePlay(_ sender: Any) {
        
        if (oldTapePlayer!.isPlaying)
        {
            oldTapePlayer!.pause();
            oldTapeButton.backgroundColor = halloweenOrange
            oldTapeButton.setTitleColor(UIColor.black, for: .normal)
            oldTapeButton.setImage(UIImage(named: "old_tape"), for: .normal)
        }
        else
        {
            oldTapePlayer!.play();
            oldTapeButton.backgroundColor = halloweenOrangeHighlight
            oldTapeButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func criesOfInsanityPlay(_ sender: Any) {
        
        if (criesOfInsanityPlayer!.isPlaying)
        {
            criesOfInsanityPlayer!.pause();
            criesOfInsanityButton.backgroundColor = halloweenOrange
            criesOfInsanityButton.setTitleColor(UIColor.black, for: .normal)
            criesOfInsanityButton.setImage(UIImage(named: "dispair"), for: .normal)
        }
        else
        {
            criesOfInsanityPlayer!.play();
            criesOfInsanityButton.backgroundColor = halloweenOrangeHighlight
            criesOfInsanityButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    
    @IBAction func criesHellPlay(_ sender: Any) {
        
        if (criesHellPlayer!.isPlaying)
        {
            criesHellPlayer!.pause();
            criesHellButton.backgroundColor = halloweenOrange
            criesHellButton.setTitleColor(UIColor.black, for: .normal)
            criesHellButton.setImage(UIImage(named: "cries_hell"), for: .normal)
        }
        else
        {
            criesHellPlayer!.play();
            criesHellButton.backgroundColor = halloweenOrangeHighlight
            criesHellButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
}
