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
    var criesHellPlayer: AVAudioPlayer?
    var spaceTerrorsPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            criesHellPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "cries_from_hell", ofType: "mp3")!))
            criesHellPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            spaceTerrorsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "space_terror", ofType: "mp3")!))
            spaceTerrorsPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func ghostSongPlay(_ sender: Any) {
        
        if (ghostSongPlayer!.isPlaying)
        {
            ghostSongPlayer!.pause();
        }
        else
        {
            ghostSongPlayer!.play();
        }
    }
    
    @IBAction func oldTapePlay(_ sender: Any) {
        
        if (oldTapePlayer!.isPlaying)
        {
            oldTapePlayer!.pause();
        }
        else
        {
            oldTapePlayer!.play();
        }
    }
    
    @IBAction func criesHellPlay(_ sender: Any) {
        
        if (criesHellPlayer!.isPlaying)
        {
            criesHellPlayer!.pause();
        }
        else
        {
            criesHellPlayer!.play();
        }
    }
    
    @IBAction func spaceTerrorsPlay(_ sender: Any) {
        
        if (spaceTerrorsPlayer!.isPlaying)
        {
            spaceTerrorsPlayer!.pause();
        }
        else
        {
            spaceTerrorsPlayer!.play();
        }
    }
}
