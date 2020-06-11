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
    
    var ultraTerrorPlayer: AVAudioPlayer?
    var hauntedHousePlayer: AVAudioPlayer?
    var spookySoundsPlayer: AVAudioPlayer?
    var insaneAsylumPlayer: AVAudioPlayer?
    var spaceTerrorPlayer: AVAudioPlayer?
    var dontLetThemInPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ultraTerrorButton.startAnimatingPressActions()
//        hauntedHouseButton.startAnimatingPressActions()
//        spookySoundsButton.startAnimatingPressActions()
//        spaceTerrorButton.startAnimatingPressActions()
//        dontLetThemInButton.startAnimatingPressActions()
        
        do {
            
            ultraTerrorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ultra_terror", ofType: "mp3")!))
            ultraTerrorPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            spookySoundsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "long_mix", ofType: "mp3")!))
            spookySoundsPlayer?.prepareToPlay()
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
            ultraTerrorButton.backgroundColor = halloweenOrange
            ultraTerrorButton.setTitleColor(UIColor.black, for: .normal)
            ultraTerrorButton.setImage(UIImage(named: "ultra_terror"), for: .normal)
            
        }
        else
        {
            ultraTerrorPlayer!.play();
            ultraTerrorButton.backgroundColor = halloweenOrangeHighlight
            ultraTerrorButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    
    @IBAction func hauntedHousePlay(_ sender: UIButton) {
        
        if (hauntedHousePlayer!.isPlaying)
        {
            hauntedHousePlayer!.pause();
            hauntedHouseButton.backgroundColor = halloweenOrange
            hauntedHouseButton.setTitleColor(UIColor.black, for: .normal)
            hauntedHouseButton.setImage(UIImage(named: "haunted_organ"), for: .normal)
            
        }
        else
        {
            hauntedHousePlayer!.play();
            hauntedHouseButton.backgroundColor = halloweenOrangeHighlight
            hauntedHouseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func spookySoundsPlayer(_ sender: UIButton) {
        
        if (spookySoundsPlayer!.isPlaying)
        {
            spookySoundsPlayer!.pause();
            spookySoundsButton.backgroundColor = halloweenOrange
            spookySoundsButton.setTitleColor(UIColor.black, for: .normal)
            spookySoundsButton.setImage(UIImage(named: "spooky_sounds"), for: .normal)
            
        }
        else
        {
            spookySoundsPlayer!.play();
            spookySoundsButton.backgroundColor = halloweenOrangeHighlight
            spookySoundsButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    
    @IBAction func spaceTerrorPlayer(_ sender: UIButton) {
        
        if (spaceTerrorPlayer!.isPlaying)
        {
            spaceTerrorPlayer!.pause();
            spaceTerrorButton.backgroundColor = halloweenOrange
            spaceTerrorButton.setTitleColor(UIColor.black, for: .normal)
            spaceTerrorButton.setImage(UIImage(named: "space_terrors"), for: .normal)
            
        }
        else
        {
            spaceTerrorPlayer!.play();
            spaceTerrorButton.backgroundColor = halloweenOrangeHighlight
            spaceTerrorButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func dontLetThemIn(_ sender: UIButton) {
        
        if (dontLetThemInPlayer!.isPlaying)
        {
            dontLetThemInPlayer!.pause();
            dontLetThemInButton.backgroundColor = halloweenOrange
            dontLetThemInButton.setTitleColor(UIColor.black, for: .normal)
            dontLetThemInButton.setImage(UIImage(named: "key"), for: .normal)
            
        }
        else
        {
            dontLetThemInPlayer!.play();
            dontLetThemInButton.backgroundColor = halloweenOrangeHighlight
            dontLetThemInButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
}
