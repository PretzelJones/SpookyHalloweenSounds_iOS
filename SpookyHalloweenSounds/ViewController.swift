//
//  ViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/29/18.
//  Copyright © 2019 Bosson Design. All rights reserved.
//
//  Version 1.0.5 Build 6

import UIKit
import AVFoundation
import StoreKit
// MARK: test comment - again and again
class ViewController: UIViewController {
    
    var longMixPlayer: AVAudioPlayer?
    var ultraTerrorPlayer: AVAudioPlayer?
    var insaneAsylumPlayer: AVAudioPlayer?
    var witchCacklePlayer: AVAudioPlayer?
    var blackCatPlayer: AVAudioPlayer?
    var creakyDoorPlayer: AVAudioPlayer?
    var monsterGrowlPlayer: AVAudioPlayer?
    var spookyChainsPlayer: AVAudioPlayer?
    var thunderStormPlayer: AVAudioPlayer?
    var vampireBatPlayer: AVAudioPlayer?
    var scaryScreamPlayer: AVAudioPlayer?
    var zombieGroanPlayer: AVAudioPlayer?
    var ghostBooPlayer: AVAudioPlayer?
    var wereWolfHowlPlayer: AVAudioPlayer?
    var poltergeistVoicePlayer: AVAudioPlayer?
    var zombieCallPlayer: AVAudioPlayer?
    var catScreamPlayer: AVAudioPlayer?
    var wraithWailPlayer: AVAudioPlayer?
    var spookyOwlPlayer: AVAudioPlayer?
    var chainedGhoulPlayer: AVAudioPlayer?
    var terrifiedScreamPlayer: AVAudioPlayer?
    var hauntedOrganPlayer: AVAudioPlayer?
    var scareCrowPlayer: AVAudioPlayer?
    var blowingWindPlayer: AVAudioPlayer?
    var ghostlyWhisperPlayer: AVAudioPlayer?
    var draculaLaughPlayer: AVAudioPlayer?
    var wolfCryPlayer: AVAudioPlayer?
    var knockKnockPlayer: AVAudioPlayer?
    var igorGrumblePlayer: AVAudioPlayer?
    var warningBellsPlayer: AVAudioPlayer?
    var painfulMoanPlayer: AVAudioPlayer?
    var witchesCauldronPlayer: AVAudioPlayer?
    var ghostlyChildrenPlayer: AVAudioPlayer?
    var hauntedSwampPlayer: AVAudioPlayer?
    var torturedSoulsPlayer: AVAudioPlayer?
    var chillingHornPlayer: AVAudioPlayer?
    
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
            
            witchCacklePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "witch_laugh", ofType: "mp3")!))
            witchCacklePlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        do {
            
            blackCatPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "black_cat", ofType: "mp3")!))
            blackCatPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            monsterGrowlPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "monster_growl", ofType: "mp3")!))
            monsterGrowlPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            creakyDoorPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "creaky_door", ofType: "mp3")!))
            creakyDoorPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            spookyChainsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "spooky_chains", ofType: "mp3")!))
            spookyChainsPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            //fails
            thunderStormPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "thunder", ofType: "mp3")!))
            thunderStormPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            vampireBatPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "vampire_bat", ofType: "mp3")!))
            vampireBatPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            scaryScreamPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "scary_scream", ofType: "mp3")!))
            scaryScreamPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            zombieGroanPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "zombie", ofType: "mp3")!))
            zombieGroanPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            ghostBooPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ghost_boo", ofType: "mp3")!))
            ghostBooPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            wereWolfHowlPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "werewolf_howl", ofType: "mp3")!))
            wereWolfHowlPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            poltergeistVoicePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "poltergeist_voice", ofType: "mp3")!))
            poltergeistVoicePlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            zombieCallPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "zombie_come", ofType: "mp3")!))
            zombieCallPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            catScreamPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "cat_scream", ofType: "mp3")!))
            catScreamPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            wraithWailPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "wraith_wail", ofType: "wav")!))
            wraithWailPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            spookyOwlPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "spooky_owl", ofType: "wav")!))
            spookyOwlPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            chainedGhoulPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chained_ghoul", ofType: "wav")!))
            chainedGhoulPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            terrifiedScreamPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "terrified_scream", ofType: "mp3")!))
            terrifiedScreamPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            hauntedOrganPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "haunted_organ", ofType: "mp3")!))
            hauntedOrganPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            scareCrowPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "scarecrow", ofType: "mp3")!))
            scareCrowPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            blowingWindPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "blowing_wind", ofType: "wav")!))
            blowingWindPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            ghostlyWhisperPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ghostly_whisper", ofType: "mp3")!))
            ghostlyWhisperPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            draculaLaughPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dracula_laugh", ofType: "mp3")!))
            draculaLaughPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            wolfCryPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "wolf_cry", ofType: "mp3")!))
            wolfCryPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            knockKnockPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "knock_knock", ofType: "mp3")!))
            knockKnockPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            igorGrumblePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "igor_grumble", ofType: "mp3")!))
            igorGrumblePlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            warningBellsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "warning_bells", ofType: "mp3")!))
            warningBellsPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            painfulMoanPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "painful_moan", ofType: "mp3")!))
            painfulMoanPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            witchesCauldronPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bubbles", ofType: "wav")!))
            witchesCauldronPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            ghostlyChildrenPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "scary_nursery", ofType: "mp3")!))
            ghostlyChildrenPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            hauntedSwampPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "haunted_swamp", ofType: "mp3")!))
            hauntedSwampPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
        do {
            
            torturedSoulsPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "tortured_souls", ofType: "mp3")!))
            torturedSoulsPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        do {
            
            chillingHornPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chilling_horn", ofType: "mp3")!))
            chillingHornPlayer?.prepareToPlay()
        }
        catch {
            print(error)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SKStoreReviewController.requestReview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ultraTerrorPlay(_ sender: Any) {
        
        if (ultraTerrorPlayer!.isPlaying)
        {
            ultraTerrorPlayer!.pause();
            
        }
        else
        {
            ultraTerrorPlayer!.play();
        }
    }

    @IBAction func longMixPlay(_ sender: Any) {
        
        if (longMixPlayer!.isPlaying)
        {
            longMixPlayer!.pause();
            
        }
        else
        {
            longMixPlayer!.play();
        }
    }

    @IBAction func insaneAsylumPlay(_ sender: Any) {
        
        if (insaneAsylumPlayer!.isPlaying)
        {
            insaneAsylumPlayer!.pause();
            
        }
        else
        {
            insaneAsylumPlayer!.play();
        }
    }
    
    @IBAction func witchCacklePlay(_ sender: Any) {
        
        witchCacklePlayer?.play();
    }
    
    @IBAction func blackCatPlay(_ sender: Any) {
        
        blackCatPlayer?.play();
    }
    
    @IBAction func monsterGrowlPlay(_ sender: Any) {
        
        monsterGrowlPlayer?.play();
    }
    
    @IBAction func creakyDoorPlay(_ sender: Any) {
        
        creakyDoorPlayer?.play();
    }
    
    @IBAction func spookyChainsPlay(_ sender: Any) {
        
        spookyChainsPlayer?.play();
    }
    
    @IBAction func thunderStormPlay(_ sender: Any) {
        
        thunderStormPlayer?.play();
    }
    
    @IBAction func vampireBatPlay(_ sender: Any) {
        
        vampireBatPlayer?.play();
    }
    
    @IBAction func scaryScreamPlay(_ sender: Any) {
        
        scaryScreamPlayer?.play();
    }
    
    @IBAction func zombieGroanPlay(_ sender: Any) {
        
        zombieGroanPlayer?.play();
    }
    
    @IBAction func ghostBooPlay(_ sender: Any) {
        
        ghostBooPlayer?.play();
    }
    
    @IBAction func wereWolfHowlPlay(_ sender: Any) {
        
        wereWolfHowlPlayer?.play();
    }
    
    @IBAction func poltergeistVoicePlay(_ sender: Any) {
        
        poltergeistVoicePlayer?.play();
    }
    
    @IBAction func zombieCallPlay(_ sender: Any) {
        
        zombieCallPlayer?.play();
    }
    
    @IBAction func catScreamPlay(_ sender: Any) {
        
        catScreamPlayer?.play();
    }
    
    @IBAction func wraithWailPlay(_ sender: Any) {
        
        wraithWailPlayer?.play();
    }
    
    @IBAction func spookyOwlPlay(_ sender: Any) {
        
        spookyOwlPlayer?.play();
    }
    
    @IBAction func chainedGhoulPlay(_ sender: Any) {
        
        chainedGhoulPlayer?.play();
    }
    
    @IBAction func terrifiedScreamPlay(_ sender: Any) {
        
        terrifiedScreamPlayer?.play();
    }
    
    @IBAction func hauntedOrganPlay(_ sender: Any) {
        
        hauntedOrganPlayer?.play();
    }
    
    @IBAction func scareCrowPlay(_ sender: Any) {
        
        scareCrowPlayer?.play();
    }
    
    @IBAction func blowingWindPlay(_ sender: Any) {
        
        blowingWindPlayer?.play();
    }
    
    @IBAction func ghostlyWhisperPlay(_ sender: Any) {
        
        ghostlyWhisperPlayer?.play();
    }
    
    @IBAction func draculaLaughPlay(_ sender: Any) {
        
        draculaLaughPlayer?.play();
    }
    
    @IBAction func wolfCryPlay(_ sender: Any) {
        
        wolfCryPlayer?.play();
    }
    
    @IBAction func knockKnockPlay(_ sender: Any) {
        
        knockKnockPlayer?.play();
    }
    
    @IBAction func igorGrumblePlay(_ sender: Any) {
        
        igorGrumblePlayer?.play();
    }
    
    @IBAction func warningBellsPlay(_ sender: Any) {
        
        warningBellsPlayer?.play();
    }
    
    @IBAction func painfulMoanPlay(_ sender: Any) {
        
        painfulMoanPlayer?.play();
    }
    
    @IBAction func witchesCauldronPlay(_ sender: Any) {
        
        witchesCauldronPlayer?.play();
    }
    
    @IBAction func ghostlyChildrenPlay(_ sender: Any) {
        
        ghostlyChildrenPlayer?.play();
    }
    
    @IBAction func hauntedSwampPlay(_ sender: Any) {
        
        hauntedSwampPlayer?.play();
    }
    
    @IBAction func torturedSoulsPlay(_ sender: Any) {
        
        torturedSoulsPlayer?.play();
    }
    
    @IBAction func chillingHornPlay(_ sender: Any) {
        
        chillingHornPlayer?.play();
    }
    
}
