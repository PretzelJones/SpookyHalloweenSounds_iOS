//
//  LongMixViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/5/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class LongMixViewController: UIViewController {
    
    @IBOutlet weak var ultraTerrorButton: UIButton!
    @IBOutlet weak var hauntedHouseButton: UIButton!
    @IBOutlet weak var spookySoundsButton: UIButton!
    @IBOutlet weak var spaceTerrorButton: UIButton!
    @IBOutlet weak var dontLetThemInButton: UIButton!
    
    
    var longMixPlayer: AVAudioPlayer?
    var ultraTerrorPlayer: AVAudioPlayer?
    var insaneAsylumPlayer: AVAudioPlayer?
    var hauntedHousePlayer: AVAudioPlayer?
    var spaceTerrorPlayer: AVAudioPlayer?
    var dontLetThemInPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            ultraTerrorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ultra_terror", ofType: "mp3")!))
            ultraTerrorPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            longMixPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "long_mix", ofType: "mp3")!))
            longMixPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            insaneAsylumPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chilling_cries", ofType: "mp3")!))
            insaneAsylumPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            hauntedHousePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "haunted_house", ofType: "mp3")!))
            hauntedHousePlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            spaceTerrorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "space_terror", ofType: "mp3")!))
            spaceTerrorPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            dontLetThemInPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dont_let_in", ofType: "mp3")!))
            dontLetThemInPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
    }
    
    
    @IBAction func ultraTerrorPlay(_ sender: UIButton) {
        
        if (ultraTerrorPlayer!.isPlaying)
        {
            ultraTerrorPlayer!.pause();
            
        }
        else
        {
            ultraTerrorPlayer!.play();
        }
        
    }
    
    @IBAction func hauntedHousePlay(_ sender: UIButton) {
        
        if (hauntedHousePlayer!.isPlaying)
        {
            hauntedHousePlayer!.pause();
            
        }
        else
        {
            hauntedHousePlayer!.play();
        }
    }
    
    @IBAction func spookySoundsPlayer(_ sender: UIButton) {
        
        if (longMixPlayer!.isPlaying)
        {
            longMixPlayer!.pause();
            
        }
        else
        {
            longMixPlayer!.play();
        }
    }
    
    
    @IBAction func spaceTerrorPlayer(_ sender: UIButton) {
        
        if (spaceTerrorPlayer!.isPlaying)
        {
            spaceTerrorPlayer!.pause();
            
        }
        else
        {
            spaceTerrorPlayer!.play();
        }
    }
    
    @IBAction func dontLetThemIn(_ sender: UIButton) {
        
        if (dontLetThemInPlayer!.isPlaying)
        {
            dontLetThemInPlayer!.pause();
            
        }
        else
        {
            dontLetThemInPlayer!.play();
        }
    }
    
}
