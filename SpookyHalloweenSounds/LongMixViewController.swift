//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/5/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class LongMixViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var ultraTerrorButton: UIButton!
    @IBOutlet weak var hauntedHouseButton: UIButton!
    @IBOutlet weak var spookySoundsButton: UIButton!
    @IBOutlet weak var spaceTerrorButton: UIButton!
    @IBOutlet weak var dontLetThemInButton: UIButton!
    
    var ultraTerrorPlayer: AVAudioPlayer?
    var hauntedHousePlayer: AVAudioPlayer?
    var spookySoundsPlayer: AVAudioPlayer?
    var insaneAsylumPlayer: AVAudioPlayer?
    var spaceTerrorPlayer: AVAudioPlayer?
    var dontLetThemInPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ultraTerrorButton.noHighlight(ultraTerrorButton)
        spookySoundsButton.noHighlight(spookySoundsButton)
        hauntedHouseButton.noHighlight(hauntedHouseButton)
        spaceTerrorButton.noHighlight(spaceTerrorButton)
        dontLetThemInButton.noHighlight(dontLetThemInButton)
        
        do {
            
            ultraTerrorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ultra_terror", ofType: "mp3")!))
            ultraTerrorPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
        do {
            
            spookySoundsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "long_mix", ofType: "mp3")!))
            spookySoundsPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)        }
        
        do {
            
            hauntedHousePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "haunted_house", ofType: "mp3")!))
            hauntedHousePlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)        }
        
        do {
            
            spaceTerrorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "space_terror", ofType: "mp3")!))
            spaceTerrorPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)        }
        
        do {
            
            dontLetThemInPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dont_let_in", ofType: "mp3")!))
            dontLetThemInPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)        }
    }
    
    @IBAction func ultraTerrorPlay(_ sender: UIButton) {
        
        ultraTerrorButton.pulsate(ultraTerrorButton)
        ultraTerrorButton.haptic(ultraTerrorButton)
        
        if (ultraTerrorPlayer!.isPlaying)
        {
            ultraTerrorPlayer?.delegate = self
            ultraTerrorPlayer!.pause();
            ultraTerrorButton.backgroundColor = halloweenOrange
            ultraTerrorButton.setImage(UIImage(named: "ultra_terror"), for: .normal)
            
        }
        else
        {
            ultraTerrorPlayer?.delegate = self
            ultraTerrorPlayer!.play();
            ultraTerrorPlayer!.numberOfLoops = -1
            ultraTerrorButton.backgroundColor = halloweenOrangeHighlight
            ultraTerrorButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    
    @IBAction func hauntedHousePlay(_ sender: UIButton) {
        
        hauntedHouseButton.pulsate(hauntedHouseButton)
        hauntedHouseButton.haptic(hauntedHouseButton)
        
        if (hauntedHousePlayer!.isPlaying)
        {
            hauntedHousePlayer?.delegate = self
            hauntedHousePlayer!.pause();
            hauntedHouseButton.backgroundColor = halloweenOrange
            hauntedHouseButton.setImage(UIImage(named: "haunted_circus"), for: .normal)
            
        }
        else
        {
            hauntedHousePlayer?.delegate = self
            hauntedHousePlayer!.play();
            hauntedHousePlayer!.numberOfLoops = -1
            hauntedHouseButton.backgroundColor = halloweenOrangeHighlight
            hauntedHouseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func spookySoundsPlayer(_ sender: UIButton) {
        
        spookySoundsButton.pulsate(spookySoundsButton)
        spookySoundsButton.haptic(spookySoundsButton)
        
        if (spookySoundsPlayer!.isPlaying)
        {
            spookySoundsPlayer?.delegate = self
            spookySoundsPlayer!.pause();
            spookySoundsButton.backgroundColor = halloweenOrange
            spookySoundsButton.setImage(UIImage(named: "spooky_sounds"), for: .normal)
            
        }
        else
        {
            spookySoundsPlayer?.delegate = self
            spookySoundsPlayer!.play();
            spookySoundsPlayer!.numberOfLoops = -1
            spookySoundsButton.backgroundColor = halloweenOrangeHighlight
            spookySoundsButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func spaceTerrorPlayer(_ sender: UIButton) {
        
        spaceTerrorButton.pulsate(spaceTerrorButton)
        spaceTerrorButton.haptic(spaceTerrorButton)
        
        if (spaceTerrorPlayer!.isPlaying)
        {
            spaceTerrorPlayer?.delegate = self
            spaceTerrorPlayer!.pause();
            spaceTerrorButton.backgroundColor = halloweenOrange
            spaceTerrorButton.setImage(UIImage(named: "space_terrors"), for: .normal)
            
        }
        else
        {
            spaceTerrorPlayer?.delegate = self
            spaceTerrorPlayer!.play();
            spaceTerrorPlayer!.numberOfLoops = -1
            spaceTerrorButton.backgroundColor = halloweenOrangeHighlight
            spaceTerrorButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func dontLetThemIn(_ sender: UIButton) {
        
        dontLetThemInButton.pulsate(dontLetThemInButton)
        dontLetThemInButton.haptic(dontLetThemInButton)
        
        if (dontLetThemInPlayer!.isPlaying)
        {
            dontLetThemInPlayer?.delegate = self
            dontLetThemInPlayer!.pause();
            dontLetThemInButton.backgroundColor = halloweenOrange
            dontLetThemInButton.setImage(UIImage(named: "key"), for: .normal)
            
        }
        else
        {
            dontLetThemInPlayer?.delegate = self
            dontLetThemInPlayer!.play();
            dontLetThemInPlayer!.numberOfLoops = -1
            dontLetThemInButton.backgroundColor = halloweenOrangeHighlight
            dontLetThemInButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === ultraTerrorPlayer) {
            ultraTerrorButton.backgroundColor = halloweenOrange
            ultraTerrorButton.setImage(UIImage(named: "ultra_terror"), for: .normal)
            ultraTerrorButton.pulsate2(ultraTerrorButton)
        } else if (player === hauntedHousePlayer) {
            hauntedHouseButton.backgroundColor = halloweenOrange
            hauntedHouseButton.setImage(UIImage(named: "haunted_circus"), for: .normal)
            hauntedHouseButton.pulsate2(hauntedHouseButton)
        } else if (player === spookySoundsPlayer) {
            spookySoundsButton.backgroundColor = halloweenOrange
            spookySoundsButton.setImage(UIImage(named: "spooky_sounds"), for: .normal)
            spookySoundsButton.pulsate2(spookySoundsButton)
        } else if (player === spaceTerrorPlayer) {
            spaceTerrorButton.backgroundColor = halloweenOrange
            spaceTerrorButton.setImage(UIImage(named: "space_terrors"), for: .normal)
            spaceTerrorButton.pulsate2(spaceTerrorButton)
        } else if (player === dontLetThemInPlayer) {
            dontLetThemInButton.backgroundColor = halloweenOrange
            dontLetThemInButton.setImage(UIImage(named: "key"), for: .normal)
            dontLetThemInButton.pulsate2(dontLetThemInButton)
        }
    }
}
