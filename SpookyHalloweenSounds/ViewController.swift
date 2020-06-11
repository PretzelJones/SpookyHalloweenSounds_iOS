//
//  ViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/29/18.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import AVFoundation
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var witchCackleButton: UIButton!
    @IBOutlet weak var blackCatButton: UIButton!
    @IBOutlet weak var creepyLaughButton: UIButton!
    @IBOutlet weak var creakyDoorButton: UIButton!
    @IBOutlet weak var horrorAmbianceButton: UIButton!
    @IBOutlet weak var monsterGrowlButton: UIButton!
    @IBOutlet weak var monsterWalkingButton: UIButton!
    @IBOutlet weak var spookyChainsButton: UIButton!
    @IBOutlet weak var thunderStormButton: UIButton!
    @IBOutlet weak var scaryScreamButton: UIButton!
    @IBOutlet weak var zombieGroanButton: UIButton!
    @IBOutlet weak var ghostBooButton: UIButton!
    @IBOutlet weak var werewolfHowlButton: UIButton!
    @IBOutlet weak var poltergeistVoiceButton: UIButton!
    @IBOutlet weak var zombieCallButton: UIButton!
    @IBOutlet weak var catScreamButton: UIButton!
    @IBOutlet weak var wraithWailButton: UIButton!
    @IBOutlet weak var spookyOwlButton: UIButton!
    @IBOutlet weak var chainedGhoulButton: UIButton!
    @IBOutlet weak var terrifiedScreamButton: UIButton!
    @IBOutlet weak var hauntedOrganButton: UIButton!
    @IBOutlet weak var scarecrowButton: UIButton!
    @IBOutlet weak var blowingWindButton: UIButton!
    @IBOutlet weak var ghostlyWhisperButton: UIButton!
    @IBOutlet weak var draculaLaughButton: UIButton!
    @IBOutlet weak var wolfCryButton: UIButton!
    @IBOutlet weak var knockKnockButton: UIButton!
    @IBOutlet weak var igorGrumbleButton: UIButton!
    @IBOutlet weak var horrorMovieButton: UIButton!
    @IBOutlet weak var warningBellsButton: UIButton!
    @IBOutlet weak var painfulMoanButton: UIButton!
    @IBOutlet weak var witchesCauldronButton: UIButton!
    @IBOutlet weak var ghostlyChildrenButton: UIButton!
    @IBOutlet weak var hauntedSwampButton: UIButton!
    @IBOutlet weak var torturedSoulsButton: UIButton!
    @IBOutlet weak var chillingHornButton: UIButton!
    
    var witchCacklePlayer: AVAudioPlayer?
    var blackCatPlayer: AVAudioPlayer?
    var creepyLaughPlayer: AVAudioPlayer?
    var creakyDoorPlayer: AVAudioPlayer?
    var horrorAmbiancePlayer: AVAudioPlayer?
    var monsterGrowlPlayer: AVAudioPlayer?
    var monsterWalkingPlayer: AVAudioPlayer?
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
    var horrorMoviePlayer: AVAudioPlayer?
    var warningBellsPlayer: AVAudioPlayer?
    var painfulMoanPlayer: AVAudioPlayer?
    var witchesCauldronPlayer: AVAudioPlayer?
    var ghostlyChildrenPlayer: AVAudioPlayer?
    var hauntedSwampPlayer: AVAudioPlayer?
    var torturedSoulsPlayer: AVAudioPlayer?
    var chillingHornPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        witchCackleButton.startAnimatingPressActions()
//        blackCatButton.startAnimatingPressActions()
//        creepyLaughButton.startAnimatingPressActions()
//        creakyDoorButton.startAnimatingPressActions()
//        horrorAmbianceButton.startAnimatingPressActions()
//        monsterGrowlButton.startAnimatingPressActions()
//        monsterWalkingButton.startAnimatingPressActions()
//        spookyChainsButton.startAnimatingPressActions()
//        thunderStormButton.startAnimatingPressActions()
//        scaryScreamButton.startAnimatingPressActions()
//        zombieGroanButton.startAnimatingPressActions()
//        ghostBooButton.startAnimatingPressActions()
//        werewolfHowlButton.startAnimatingPressActions()
//        poltergeistVoiceButton.startAnimatingPressActions()
//        zombieCallButton.startAnimatingPressActions()
//        catScreamButton.startAnimatingPressActions()
//        wraithWailButton.startAnimatingPressActions()
//        spookyOwlButton.startAnimatingPressActions()
//        chainedGhoulButton.startAnimatingPressActions()
//        terrifiedScreamButton.startAnimatingPressActions()
//        hauntedOrganButton.startAnimatingPressActions()
//        scarecrowButton.startAnimatingPressActions()
//        blowingWindButton.startAnimatingPressActions()
//        ghostlyWhisperButton.startAnimatingPressActions()
//        draculaLaughButton.startAnimatingPressActions()
//        wolfCryButton.startAnimatingPressActions()
//        knockKnockButton.startAnimatingPressActions()
//        igorGrumbleButton.startAnimatingPressActions()
//        horrorMovieButton.startAnimatingPressActions()
//        warningBellsButton.startAnimatingPressActions()
//        painfulMoanButton.startAnimatingPressActions()
//        witchesCauldronButton.startAnimatingPressActions()
//        ghostlyChildrenButton.startAnimatingPressActions()
//        hauntedSwampButton.startAnimatingPressActions()
//        torturedSoulsButton.startAnimatingPressActions()
//        chillingHornButton.startAnimatingPressActions()
        
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
            
            creepyLaughPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "evil_man", ofType: "mp3")!))
            creepyLaughPlayer?.prepareToPlay()
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
            
            monsterWalkingPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "monster_walking", ofType: "mp3")!))
            monsterWalkingPlayer?.prepareToPlay()
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
            
            horrorAmbiancePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "horror_ambience", ofType: "mp3")!))
            horrorAmbiancePlayer?.prepareToPlay()
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
            
            horrorMoviePlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "horror_film", ofType: "mp3")!))
            horrorMoviePlayer?.prepareToPlay()
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
    
    @IBAction func witchCacklePlay(_ sender: UIButton) {
        
        witchCacklePlayer?.play()
        witchCackleButton.pulsate()
    }
    
    @IBAction func blackCatPlay(_ sender: Any) {
        
        blackCatPlayer?.play()
        blackCatButton.pulsate()
    }
    @IBAction func creepyLaughPlay(_ sender: Any) {
        
        creepyLaughPlayer?.play()
        creepyLaughButton.pulsate()
    }
    
    @IBAction func horrorAmbiancePlay(_ sender: Any) {
        
        horrorAmbiancePlayer?.play()
        horrorAmbianceButton.pulsate()
    }
    @IBAction func monsterGrowlPlay(_ sender: Any) {
        
        monsterGrowlPlayer?.play()
        monsterGrowlButton.pulsate()
    }
    
    @IBAction func monsterWalkingPlay(_ sender: Any) {
        
        monsterWalkingPlayer?.play()
        monsterWalkingButton.pulsate()
    }
    
    @IBAction func creakyDoorPlay(_ sender: Any) {
        
        creakyDoorPlayer?.play()
        creakyDoorButton.pulsate()
    }
    
    @IBAction func spookyChainsPlay(_ sender: Any) {
        
        spookyChainsPlayer?.play()
        spookyChainsButton.pulsate()
    }
    
    @IBAction func thunderStormPlay(_ sender: Any) {
        
        thunderStormPlayer?.play()
        thunderStormButton.pulsate()
    }
    
//    @IBAction func vampireBatPlay(_ sender: Any) {
//
//        vampireBatPlayer?.play()
//    }
    
    @IBAction func scaryScreamPlay(_ sender: Any) {
        
        scaryScreamPlayer?.play()
        scaryScreamButton.pulsate()
    }
    
    @IBAction func zombieGroanPlay(_ sender: Any) {
        
        zombieGroanPlayer?.play()
        zombieGroanButton.pulsate()
    }
    
    @IBAction func ghostBooPlay(_ sender: Any) {
        
        ghostBooPlayer?.play()
        ghostBooButton.pulsate()
    }
    
    @IBAction func wereWolfHowlPlay(_ sender: Any) {
        
        wereWolfHowlPlayer?.play()
        werewolfHowlButton.pulsate()
    }
    
    @IBAction func poltergeistVoicePlay(_ sender: Any) {
        
        poltergeistVoicePlayer?.play()
        poltergeistVoiceButton.pulsate()
    }
    
    @IBAction func zombieCallPlay(_ sender: Any) {
        
        zombieCallPlayer?.play()
        zombieCallButton.pulsate()
    }
    
    @IBAction func catScreamPlay(_ sender: Any) {
        
        catScreamPlayer?.play()
        catScreamButton.pulsate()
    }
    
    @IBAction func wraithWailPlay(_ sender: Any) {
        
        wraithWailPlayer?.play()
        wraithWailButton.pulsate()
    }
    
    @IBAction func spookyOwlPlay(_ sender: Any) {
        
        spookyOwlPlayer?.play()
        spookyOwlButton.pulsate()
    }
    
    @IBAction func chainedGhoulPlay(_ sender: Any) {
        
        chainedGhoulPlayer?.play()
        chainedGhoulButton.pulsate()
    }
    
    @IBAction func terrifiedScreamPlay(_ sender: Any) {
        
        terrifiedScreamPlayer?.play()
        terrifiedScreamButton.pulsate()
    }
    
    @IBAction func hauntedOrganPlay(_ sender: Any) {
        
        hauntedOrganPlayer?.play()
        hauntedOrganButton.pulsate()
    }
    
    @IBAction func scareCrowPlay(_ sender: Any) {
        
        scareCrowPlayer?.play()
        scarecrowButton.pulsate()
    }
    
    @IBAction func blowingWindPlay(_ sender: Any) {
        
        blowingWindPlayer?.play()
        blowingWindButton.pulsate()
    }
    
    @IBAction func ghostlyWhisperPlay(_ sender: Any) {
        
        ghostlyWhisperPlayer?.play()
        ghostlyWhisperButton.pulsate()
    }
    
    @IBAction func draculaLaughPlay(_ sender: Any) {
        
        draculaLaughPlayer?.play()
        draculaLaughButton.pulsate()
    }
    
    @IBAction func wolfCryPlay(_ sender: Any) {
        
        wolfCryPlayer?.play()
        wolfCryButton.pulsate()
    }
    
    @IBAction func knockKnockPlay(_ sender: Any) {
        
        knockKnockPlayer?.play()
        knockKnockButton.pulsate()
    }
    
    @IBAction func igorGrumblePlay(_ sender: Any) {
        
        igorGrumblePlayer?.play()
        igorGrumbleButton.pulsate()
    }
    
    @IBAction func horrorMoviePlay(_ sender: Any) {
        
        horrorMoviePlayer?.play()
        horrorMovieButton.pulsate()
    }
    
    @IBAction func warningBellsPlay(_ sender: Any) {
        
        warningBellsPlayer?.play()
        warningBellsButton.pulsate()
    }
    
    @IBAction func painfulMoanPlay(_ sender: Any) {
        
        painfulMoanPlayer?.play()
        painfulMoanButton.pulsate()
    }
    
    @IBAction func witchesCauldronPlay(_ sender: Any) {
        
        witchesCauldronPlayer?.play()
        witchesCauldronButton.pulsate()
    }
    
    @IBAction func ghostlyChildrenPlay(_ sender: Any) {
        
        ghostlyChildrenPlayer?.play()
        ghostlyChildrenButton.pulsate()
    }
    
    @IBAction func hauntedSwampPlay(_ sender: Any) {
        
        hauntedSwampPlayer?.play()
        hauntedSwampButton.pulsate()
    }
    
    @IBAction func torturedSoulsPlay(_ sender: Any) {
        
        torturedSoulsPlayer?.play()
        torturedSoulsButton.pulsate()
    }
    
    @IBAction func chillingHornPlay(_ sender: Any) {
        
        chillingHornPlayer?.play()
        chillingHornButton.pulsate()
    }
    
}


