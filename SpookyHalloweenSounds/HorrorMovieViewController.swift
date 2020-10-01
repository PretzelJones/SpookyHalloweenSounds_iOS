//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class HorrorMovieViewController: UIViewController, AVAudioPlayerDelegate {
    
    var halloweenPlayer: AVAudioPlayer?
    var exorcistPlayer: AVAudioPlayer?
    var shiningPlayer: AVAudioPlayer?
    var nightmarePlayer: AVAudioPlayer?
    var fridayPlayer: AVAudioPlayer?
    
    @IBOutlet weak var halloweenButton: UIButton!
    @IBOutlet weak var exorcistButton: UIButton!
    @IBOutlet weak var shiningButton: UIButton!
    @IBOutlet weak var nightmareButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        halloweenButton.noHighlight(halloweenButton)
        exorcistButton.noHighlight(exorcistButton)
        shiningButton.noHighlight(shiningButton)
        nightmareButton.noHighlight(nightmareButton)
        fridayButton.noHighlight(fridayButton)
        
        do {
            
            halloweenPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "halloween", ofType: "mp3")!))
            halloweenPlayer?.prepareToPlay()
          
            //code for background play
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
        do {
            
            exorcistPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "exorcist", ofType: "mp3")!))
            exorcistPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
        do {
            
            shiningPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shining", ofType: "mp3")!))
            shiningPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
        do {
            
            nightmarePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "elm_street", ofType: "mp3")!))
            nightmarePlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
        do {
            
            fridayPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "vorhees", ofType: "mp3")!))
            fridayPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do{
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)        }
        
    }
    
    @IBAction func halloweenPlay(_ sender: UIButton) {
        
        halloweenButton.pulsate(halloweenButton)
        halloweenButton.haptic(halloweenButton)
        halloweenButton.showsTouchWhenHighlighted = true
        
        if (halloweenPlayer!.isPlaying)
        {
            halloweenPlayer?.delegate = self
            halloweenPlayer!.pause();
            halloweenButton.backgroundColor = halloweenOrange
            halloweenButton.setImage(UIImage(named: "halloween"), for: .normal)
        }
        else
        {
            halloweenPlayer?.delegate = self
            halloweenPlayer!.play();
            halloweenPlayer!.numberOfLoops = -1
            halloweenButton.backgroundColor = halloweenOrangeHighlight
            halloweenButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func exorcistPlay(_ sender: UIButton) {
        
        exorcistButton.pulsate(exorcistButton)
        exorcistButton.haptic(exorcistButton)
        exorcistButton.showsTouchWhenHighlighted = true
        
        if (exorcistPlayer!.isPlaying)
        {
            exorcistPlayer?.delegate = self
            exorcistPlayer!.pause();
            exorcistButton.backgroundColor = halloweenOrange
            exorcistButton.setImage(UIImage(named: "cross"), for: .normal)
        }
        else
        {
            exorcistPlayer?.delegate = self
            exorcistPlayer!.play();
            exorcistPlayer!.numberOfLoops = -1
            exorcistButton.backgroundColor = halloweenOrangeHighlight
            exorcistButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func shiningPlay(_ sender: UIButton) {
        
        shiningButton.pulsate(shiningButton)
        shiningButton.haptic(shiningButton)
        shiningButton.showsTouchWhenHighlighted = true
        
        if (shiningPlayer!.isPlaying)
        {
            shiningPlayer?.delegate = self
            shiningPlayer!.pause();
            shiningButton.backgroundColor = halloweenOrange
            shiningButton.setImage(UIImage(named: "shining"), for: .normal)
        }
        else
        {
            shiningPlayer?.delegate = self
            shiningPlayer!.play();
            shiningPlayer!.numberOfLoops = -1
            shiningButton.backgroundColor = halloweenOrangeHighlight
            shiningButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func nightmaterPlay(_ sender: UIButton) {
        
        nightmareButton.pulsate(nightmareButton)
        nightmareButton.haptic(nightmareButton)
        nightmareButton.showsTouchWhenHighlighted = true
        
        if (nightmarePlayer!.isPlaying)
        {
            nightmarePlayer?.delegate = self
            nightmarePlayer!.pause();
            nightmareButton.backgroundColor = halloweenOrange
            nightmareButton.setImage(UIImage(named: "freddy"), for: .normal)
        }
        else
        {
            nightmarePlayer?.delegate = self
            nightmarePlayer!.play();
            nightmarePlayer!.numberOfLoops = -1
            nightmareButton.backgroundColor = halloweenOrangeHighlight
            nightmareButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    @IBAction func fridayPlay(_ sender: Any) {
        
        fridayButton.pulsate(fridayButton)
        fridayButton.haptic(fridayButton)
        fridayButton.showsTouchWhenHighlighted = true
        
        if (fridayPlayer!.isPlaying)
        {
            fridayPlayer?.delegate = self
            fridayPlayer!.pause();
            fridayButton.backgroundColor = halloweenOrange
            fridayButton.setImage(UIImage(named: "vorhees"), for: .normal)
        }
        else
        {
            fridayPlayer?.delegate = self
            fridayPlayer!.play();
            fridayPlayer!.numberOfLoops = -1
            fridayButton.backgroundColor = halloweenOrangeHighlight
            fridayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === halloweenPlayer) {
            halloweenButton.backgroundColor = halloweenOrange
            halloweenButton.setImage(UIImage(named: "halloween"), for: .normal)
            halloweenButton.pulsate2(halloweenButton)
        } else if (player === exorcistPlayer) {
            exorcistButton.backgroundColor = halloweenOrange
            exorcistButton.setImage(UIImage(named: "cross"), for: .normal)
            exorcistButton.pulsate2(exorcistButton)
        } else if (player === shiningPlayer) {
            shiningButton.backgroundColor = halloweenOrange
            shiningButton.setImage(UIImage(named: "shining"), for: .normal)
            shiningButton.pulsate2(shiningButton)
        } else if (player === nightmarePlayer) {
            nightmareButton.backgroundColor = halloweenOrange
            nightmareButton.setImage(UIImage(named: "freddy"), for: .normal)
            nightmareButton.pulsate2(nightmareButton)
        } else if (player === fridayPlayer) {
            fridayButton.backgroundColor = halloweenOrange
            fridayButton.setImage(UIImage(named: "vorhees"), for: .normal)
            fridayButton.pulsate2(fridayButton)
        }
    }
    
}
