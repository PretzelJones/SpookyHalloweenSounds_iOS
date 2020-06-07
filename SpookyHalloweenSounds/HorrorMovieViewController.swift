//
//  HorrorMovieViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 6/6/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation

class HorrorMovieViewController: UIViewController {
    
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
        
        if (halloweenPlayer!.isPlaying)
        {
            halloweenPlayer!.pause();
            
        }
        else
        {
            halloweenPlayer!.play();
        }
    }
    
    @IBAction func exorcistPlay(_ sender: UIButton) {
        
        if (exorcistPlayer!.isPlaying)
        {
            exorcistPlayer!.pause();
            
        }
        else
        {
            exorcistPlayer!.play();
        }
    }
    
    @IBAction func shiningPlay(_ sender: UIButton) {
        
        if (shiningPlayer!.isPlaying)
        {
            shiningPlayer!.pause();
            
        }
        else
        {
            shiningPlayer!.play();
        }
    }
    
    @IBAction func nightmaterPlay(_ sender: UIButton) {
        
        if (nightmarePlayer!.isPlaying)
        {
            nightmarePlayer!.pause();
            
        }
        else
        {
            nightmarePlayer!.play();
        }
    }
    
}
