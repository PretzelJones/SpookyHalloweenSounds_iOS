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
    
    @IBOutlet weak var halloweenButton: UIButton!
    @IBOutlet weak var exorcistButton: UIButton!
    @IBOutlet weak var shiningButton: UIButton!
    @IBOutlet weak var nightmareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        halloweenButton.startAnimatingPressActions()
        //        exorcistButton.startAnimatingPressActions()
        //        shiningButton.startAnimatingPressActions()
        //        nightmareButton.startAnimatingPressActions()
        
        do {
            
            halloweenPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "halloween", ofType: "mp3")!))
            halloweenPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            exorcistPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "exorcist", ofType: "mp3")!))
            exorcistPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            shiningPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shining", ofType: "mp3")!))
            shiningPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            nightmarePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "elm_street", ofType: "mp3")!))
            nightmarePlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
    }
    
    @IBAction func halloweenPlay(_ sender: UIButton) {
        
        halloweenButton.pulsate(halloweenButton)
        
        if (halloweenPlayer!.isPlaying)
        {
            halloweenPlayer?.delegate = self
            halloweenPlayer!.pause();
            halloweenButton.backgroundColor = halloweenOrange
//            halloweenButton.setTitleColor(UIColor.black, for: .normal)
            halloweenButton.setImage(UIImage(named: "halloween"), for: .normal)
            
        }
        else
        {
            halloweenPlayer?.delegate = self
            halloweenPlayer!.play();
            halloweenButton.backgroundColor = halloweenOrangeHighlight
            halloweenButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func exorcistPlay(_ sender: UIButton) {
        
        exorcistButton.pulsate(exorcistButton)
        
        if (exorcistPlayer!.isPlaying)
        {
            exorcistPlayer?.delegate = self
            exorcistPlayer!.pause();
            exorcistButton.backgroundColor = halloweenOrange
//            exorcistButton.setTitleColor(UIColor.black, for: .normal)
            exorcistButton.setImage(UIImage(named: "cross"), for: .normal)
            
        }
        else
        {
            exorcistPlayer?.delegate = self
            exorcistPlayer!.play();
            exorcistButton.backgroundColor = halloweenOrangeHighlight
            exorcistButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func shiningPlay(_ sender: UIButton) {
        
        shiningButton.pulsate(shiningButton)
        
        if (shiningPlayer!.isPlaying)
        {
            shiningPlayer?.delegate = self
            shiningPlayer!.pause();
            shiningButton.backgroundColor = halloweenOrange
//            shiningButton.setTitleColor(UIColor.black, for: .normal)
            shiningButton.setImage(UIImage(named: "axe"), for: .normal)
            
        }
        else
        {
            shiningPlayer?.delegate = self
            shiningPlayer!.play();
            shiningButton.backgroundColor = halloweenOrangeHighlight
            shiningButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func nightmaterPlay(_ sender: UIButton) {
        
        nightmareButton.pulsate(nightmareButton)
        
        if (nightmarePlayer!.isPlaying)
        {
            nightmarePlayer?.delegate = self
            nightmarePlayer!.pause();
            nightmareButton.backgroundColor = halloweenOrange
//            nightmareButton.setTitleColor(UIColor.black, for: .normal)
            nightmareButton.setImage(UIImage(named: "freddy"), for: .normal)
        }
        else
        {
            nightmarePlayer?.delegate = self
            nightmarePlayer!.play();
            nightmareButton.backgroundColor = halloweenOrangeHighlight
            nightmareButton.setImage(UIImage(named: "pause"), for: .normal)
            
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === halloweenPlayer) {
            halloweenButton.backgroundColor = halloweenOrange
            halloweenButton.setImage(UIImage(named: "halloween"), for: .normal)
            halloweenButton.pulsate(halloweenButton)
        } else if (player === exorcistPlayer) {
            exorcistButton.backgroundColor = halloweenOrange
            exorcistButton.setImage(UIImage(named: "cross"), for: .normal)
            exorcistButton.pulsate(exorcistButton)
        } else if (player === shiningPlayer) {
            shiningButton.backgroundColor = halloweenOrange
            shiningButton.setImage(UIImage(named: "axe"), for: .normal)
            shiningButton.pulsate(shiningButton)
        } else if (player === nightmarePlayer) {
            nightmareButton.backgroundColor = halloweenOrange
            nightmareButton.setImage(UIImage(named: "freddy"), for: .normal)
            nightmareButton.pulsate(nightmareButton)
        }
    }
    
}
