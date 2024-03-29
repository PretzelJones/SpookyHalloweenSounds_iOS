//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class HorrorMovieViewController: UIViewController, AVAudioPlayerDelegate {
    
    var halloweenPlayer: AVAudioPlayer?
    var exorcistPlayer: AVAudioPlayer?
    var shiningPlayer: AVAudioPlayer?
    var nightmarePlayer: AVAudioPlayer?
    var fridayPlayer: AVAudioPlayer?
    var amityvillePlayer: AVAudioPlayer?
    
    @IBOutlet weak var halloweenButton: UIButton!
    @IBOutlet weak var exorcistButton: UIButton!
    @IBOutlet weak var shiningButton: UIButton!
    @IBOutlet weak var nightmareButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var amityvilleButton: UIButton!
    
    let halloweenLongPress = UILongPressGestureRecognizer()
    let exorcistLongPress = UILongPressGestureRecognizer()
    let shiningLongPress = UILongPressGestureRecognizer()
    let nightmareLongPress = UILongPressGestureRecognizer()
    let fridayLongPress = UILongPressGestureRecognizer()
    let amityvilleLongPress = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PopupManager.shared.showPopup(inViewController: self)
        
        halloweenButton.noHighlight(halloweenButton)
        exorcistButton.noHighlight(exorcistButton)
        shiningButton.noHighlight(shiningButton)
        nightmareButton.noHighlight(nightmareButton)
        fridayButton.noHighlight(fridayButton)
        amityvilleButton.noHighlight(amityvilleButton)
        
        // Set the target and action for each gesture recognizer
        halloweenLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        exorcistLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        shiningLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        nightmareLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        fridayLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        amityvilleLongPress.addTarget(self, action: #selector(replayButtonLongPressed(_:)))
        
        // Add the gesture recognizers to the buttons
        halloweenButton.addGestureRecognizer(halloweenLongPress)
        exorcistButton.addGestureRecognizer(exorcistLongPress)
        shiningButton.addGestureRecognizer(shiningLongPress)
        nightmareButton.addGestureRecognizer(nightmareLongPress)
        fridayButton.addGestureRecognizer(fridayLongPress)
        amityvilleButton.addGestureRecognizer(amityvilleLongPress)
        
        do {
            
            halloweenPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "halloween", ofType: "mp3")!))
            halloweenPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
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
            
            do {
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
            
            do {
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
            
            do {
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
        
        do {
            
            amityvillePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "amityville", ofType: "mp3")!))
            amityvillePlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            }
        }
        catch {
            print(error)
        }
        
    }
    
    @objc func replayButtonLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            switch gestureRecognizer {
            case halloweenLongPress:
                handleReplay(for: halloweenButton, with: halloweenPlayer)
            case exorcistLongPress:
                handleReplay(for: exorcistButton, with: exorcistPlayer)
            case shiningLongPress:
                handleReplay(for: shiningButton, with: shiningPlayer)
            case nightmareLongPress:
                handleReplay(for: nightmareButton, with: nightmarePlayer)
            case fridayLongPress:
                handleReplay(for: fridayButton, with: fridayPlayer)
            case amityvilleLongPress:
                handleReplay(for: amityvilleButton, with: amityvillePlayer)
            default:
                break
            }
        }
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
        
        if (shiningPlayer!.isPlaying){
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
    
    @IBAction func fridayPlay(_ sender: Any){
        
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
    
    @IBAction func amityPlay(_ sender: Any){
        
        amityvilleButton.pulsate(amityvilleButton)
        amityvilleButton.haptic(amityvilleButton)
        amityvilleButton.showsTouchWhenHighlighted = true
        
        if (amityvillePlayer!.isPlaying)
        {
            amityvillePlayer?.delegate = self
            amityvillePlayer!.pause()
            amityvilleButton.backgroundColor = halloweenOrange
            amityvilleButton.setImage(UIImage(named: "amityville"), for: .normal)
        }
        else
        {
            amityvillePlayer?.delegate = self
            amityvillePlayer!.play()
            amityvillePlayer!.numberOfLoops = -1
            amityvilleButton.backgroundColor = halloweenOrangeHighlight
            amityvilleButton.setImage(UIImage(named: "pause"), for: .normal)
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
        } else if (player === amityvillePlayer) {
            amityvilleButton.backgroundColor = halloweenOrange
            amityvilleButton.setImage(UIImage(named: "amityville"), for: .normal)
            amityvilleButton.pulsate2(amityvilleButton)
        }
    }
}
