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

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var loopingMixButton: UIButton!
    @IBOutlet weak var horrorThemeButton: UIButton!
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
    
    @IBAction func loopingMixesPlay(_ sender: Any) {
        
        loopingMixButton.pulsate(loopingMixButton)
    }
    
    @IBAction func horrorThemePlay(_ sender: Any) {
        
        horrorThemeButton.pulsate(horrorThemeButton)
    }
    
    @IBAction func witchCacklePlay(_ sender: UIButton) {
        
        witchCackleButton.backgroundColor = halloweenOrangeHighlight
        witchCacklePlayer?.delegate = self
        witchCacklePlayer?.play()
        witchCackleButton.pulsate(witchCackleButton)
    }
    
    @IBAction func blackCatPlay(_ sender: Any) {
        
        blackCatButton.backgroundColor = halloweenOrangeHighlight
        blackCatPlayer?.delegate = self
        blackCatPlayer?.play()
        blackCatButton.pulsate(blackCatButton)
    }
    
    @IBAction func creepyLaughPlay(_ sender: Any) {
        
        creepyLaughButton.backgroundColor = halloweenOrangeHighlight
        creepyLaughPlayer?.delegate = self
        creepyLaughPlayer?.play()
        creepyLaughButton.pulsate(creepyLaughButton)
    }
    
    @IBAction func horrorAmbiancePlay(_ sender: Any) {
        
        horrorAmbianceButton.backgroundColor = halloweenOrangeHighlight
        horrorAmbiancePlayer?.delegate = self
        horrorAmbiancePlayer?.play()
        horrorAmbianceButton.pulsate(horrorAmbianceButton)
    }
    
    @IBAction func monsterGrowlPlay(_ sender: Any) {
        
        monsterGrowlButton.backgroundColor = halloweenOrangeHighlight
        monsterGrowlPlayer?.delegate = self
        monsterGrowlPlayer?.play()
        monsterGrowlButton.pulsate(monsterGrowlButton)
    }
    
    @IBAction func monsterWalkingPlay(_ sender: Any) {
        
        monsterWalkingButton.backgroundColor = halloweenOrangeHighlight
        monsterWalkingPlayer?.delegate = self
        monsterWalkingPlayer?.play()
        monsterWalkingButton.pulsate(monsterWalkingButton)
    }
    
    @IBAction func creakyDoorPlay(_ sender: Any) {
        
        creakyDoorButton.backgroundColor = halloweenOrangeHighlight
        creakyDoorPlayer?.delegate = self
        creakyDoorPlayer?.play()
        creakyDoorButton.pulsate(creakyDoorButton)
    }
    
    @IBAction func spookyChainsPlay(_ sender: Any) {
        
        spookyChainsButton.backgroundColor = halloweenOrangeHighlight
        spookyChainsPlayer?.delegate = self
        spookyChainsPlayer?.play()
        spookyChainsButton.pulsate(spookyChainsButton)
    }
    
    @IBAction func thunderStormPlay(_ sender: Any) {
        
        thunderStormButton.backgroundColor = halloweenOrangeHighlight
        thunderStormPlayer?.delegate = self
        thunderStormPlayer?.play()
        thunderStormButton.pulsate(thunderStormButton)
    }
    
    @IBAction func scaryScreamPlay(_ sender: Any) {
        
        scaryScreamButton.backgroundColor = halloweenOrangeHighlight
        scaryScreamPlayer?.delegate = self
        scaryScreamPlayer?.play()
        scaryScreamButton.pulsate(scaryScreamButton)
    }
    
    @IBAction func zombieGroanPlay(_ sender: Any) {
        
        zombieGroanButton.backgroundColor = halloweenOrangeHighlight
        zombieGroanPlayer?.delegate = self
        zombieGroanPlayer?.play()
        zombieGroanButton.pulsate(zombieGroanButton)
    }
    
    @IBAction func ghostBooPlay(_ sender: Any) {
        
        ghostBooButton.backgroundColor = halloweenOrangeHighlight
        ghostBooPlayer?.delegate = self
        ghostBooPlayer?.play()
        ghostBooButton.pulsate(ghostBooButton)
    }
    
    @IBAction func wereWolfHowlPlay(_ sender: Any) {
        
        werewolfHowlButton.backgroundColor = halloweenOrangeHighlight
        wereWolfHowlPlayer?.delegate = self
        wereWolfHowlPlayer?.play()
        werewolfHowlButton.pulsate(werewolfHowlButton)
    }
    
    @IBAction func poltergeistVoicePlay(_ sender: Any) {
        
        poltergeistVoiceButton.backgroundColor = halloweenOrangeHighlight
        poltergeistVoicePlayer?.delegate = self
        poltergeistVoicePlayer?.play()
        poltergeistVoiceButton.pulsate(poltergeistVoiceButton)
    }
    
    @IBAction func zombieCallPlay(_ sender: Any) {
        
        zombieCallButton.backgroundColor = halloweenOrangeHighlight
        zombieCallPlayer?.delegate = self
        zombieCallPlayer?.play()
        zombieCallButton.pulsate(zombieCallButton)
    }
    
    @IBAction func catScreamPlay(_ sender: Any) {
        
        catScreamButton.backgroundColor = halloweenOrangeHighlight
        catScreamPlayer?.delegate = self
        catScreamPlayer?.play()
        catScreamButton.pulsate(catScreamButton)
    }
    
    @IBAction func wraithWailPlay(_ sender: Any) {
        
        wraithWailButton.backgroundColor = halloweenOrangeHighlight
        wraithWailPlayer?.delegate = self
        wraithWailPlayer?.play()
        wraithWailButton.pulsate(wraithWailButton)
    }
    
    @IBAction func spookyOwlPlay(_ sender: Any) {
        
        spookyOwlButton.backgroundColor = halloweenOrangeHighlight
        spookyOwlPlayer?.delegate = self
        spookyOwlPlayer?.play()
        spookyOwlButton.pulsate(spookyOwlButton)
    }
    
    @IBAction func chainedGhoulPlay(_ sender: Any) {
        
        chainedGhoulButton.backgroundColor = halloweenOrangeHighlight
        chainedGhoulPlayer?.delegate = self
        chainedGhoulPlayer?.play()
        chainedGhoulButton.pulsate(chainedGhoulButton)
    }
    
    @IBAction func terrifiedScreamPlay(_ sender: Any) {
        
        terrifiedScreamButton.backgroundColor = halloweenOrangeHighlight
        terrifiedScreamPlayer?.delegate = self
        terrifiedScreamPlayer?.play()
        terrifiedScreamButton.pulsate(terrifiedScreamButton)
    }
    
    @IBAction func hauntedOrganPlay(_ sender: Any) {
        
        hauntedOrganButton.backgroundColor = halloweenOrangeHighlight
        hauntedOrganPlayer?.delegate = self
        hauntedOrganPlayer?.play()
        hauntedOrganButton.pulsate(hauntedOrganButton)
    }
    
    @IBAction func scareCrowPlay(_ sender: Any) {
        
        scarecrowButton.backgroundColor = halloweenOrangeHighlight
        scareCrowPlayer?.delegate = self
        scareCrowPlayer?.play()
        scarecrowButton.pulsate(scarecrowButton)
    }
    
    @IBAction func blowingWindPlay(_ sender: Any) {
        
        blowingWindButton.backgroundColor = halloweenOrangeHighlight
        blowingWindPlayer?.delegate = self
        blowingWindPlayer?.play()
        blowingWindButton.pulsate(blowingWindButton)
    }
    
    @IBAction func ghostlyWhisperPlay(_ sender: Any) {
        
        ghostlyWhisperButton.backgroundColor = halloweenOrangeHighlight
        ghostlyWhisperPlayer?.delegate = self
        ghostlyWhisperPlayer?.play()
        ghostlyWhisperButton.pulsate(ghostlyWhisperButton)
    }
    
    @IBAction func draculaLaughPlay(_ sender: Any) {
        
        draculaLaughButton.backgroundColor = halloweenOrangeHighlight
        draculaLaughPlayer?.delegate = self
        draculaLaughPlayer?.play()
        draculaLaughButton.pulsate(draculaLaughButton)
    }
    
    @IBAction func wolfCryPlay(_ sender: Any) {
        
        wolfCryButton.backgroundColor = halloweenOrangeHighlight
        wolfCryPlayer?.delegate = self
        wolfCryPlayer?.play()
        wolfCryButton.pulsate(wolfCryButton)
    }
    
    @IBAction func knockKnockPlay(_ sender: Any) {
        
        knockKnockButton.backgroundColor = halloweenOrangeHighlight
        knockKnockPlayer?.delegate = self
        knockKnockPlayer?.play()
        knockKnockButton.pulsate(knockKnockButton)
    }
    
    @IBAction func igorGrumblePlay(_ sender: Any) {
        
        igorGrumbleButton.backgroundColor = halloweenOrangeHighlight
        igorGrumblePlayer?.delegate = self
        igorGrumblePlayer?.play()
        igorGrumbleButton.pulsate(igorGrumbleButton)
    }
    
    @IBAction func horrorMoviePlay(_ sender: Any) {
        
        horrorMovieButton.backgroundColor = halloweenOrangeHighlight
        horrorMoviePlayer?.delegate = self
        horrorMoviePlayer?.play()
        horrorMovieButton.pulsate(horrorMovieButton)
    }
    
    @IBAction func warningBellsPlay(_ sender: Any) {
        
        warningBellsButton.backgroundColor = halloweenOrangeHighlight
        warningBellsPlayer?.delegate = self
        warningBellsPlayer?.play()
        warningBellsButton.pulsate(warningBellsButton)
    }
    
    @IBAction func painfulMoanPlay(_ sender: Any) {
        
        painfulMoanButton.backgroundColor = halloweenOrangeHighlight
        painfulMoanPlayer?.delegate = self
        painfulMoanPlayer?.play()
        painfulMoanButton.pulsate(painfulMoanButton)
    }
    
    @IBAction func witchesCauldronPlay(_ sender: Any) {
        
        witchesCauldronButton.backgroundColor = halloweenOrangeHighlight
        witchesCauldronPlayer?.delegate = self
        witchesCauldronPlayer?.play()
        witchesCauldronButton.pulsate(witchesCauldronButton)
    }
    
    @IBAction func ghostlyChildrenPlay(_ sender: Any) {
        
        ghostlyChildrenButton.backgroundColor = halloweenOrangeHighlight
        ghostlyChildrenPlayer?.delegate = self
        ghostlyChildrenPlayer?.play()
        ghostlyChildrenButton.pulsate(ghostlyChildrenButton)
    }
    
    @IBAction func hauntedSwampPlay(_ sender: Any) {
        
        hauntedSwampButton.backgroundColor = halloweenOrangeHighlight
        hauntedSwampPlayer?.delegate = self
        hauntedSwampPlayer?.play()
        hauntedSwampButton.pulsate(hauntedSwampButton)
    }
    
    @IBAction func torturedSoulsPlay(_ sender: Any) {
        
        torturedSoulsButton.backgroundColor = halloweenOrangeHighlight
        torturedSoulsPlayer?.delegate = self
        torturedSoulsPlayer?.play()
        torturedSoulsButton.pulsate(torturedSoulsButton)
    }
    
    @IBAction func chillingHornPlay(_ sender: Any) {
        
        chillingHornButton.backgroundColor = halloweenOrangeHighlight
        chillingHornPlayer?.delegate = self
        chillingHornPlayer?.play()
        chillingHornButton.pulsate(chillingHornButton)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === witchCacklePlayer) {
            witchCackleButton.backgroundColor = halloweenOrange
        } else if (player === blackCatPlayer) {
            blackCatButton.backgroundColor = halloweenOrange
        } else if (player === creepyLaughPlayer) {
            creepyLaughButton.backgroundColor = halloweenOrange
        } else if (player === horrorAmbiancePlayer) {
            horrorAmbianceButton.backgroundColor = halloweenOrange
        } else if (player === monsterGrowlPlayer) {
            monsterGrowlButton.backgroundColor = halloweenOrange
        } else if (player === monsterWalkingPlayer) {
            monsterWalkingButton.backgroundColor = halloweenOrange
        } else if (player === creakyDoorPlayer) {
            creakyDoorButton.backgroundColor = halloweenOrange
        } else if (player === spookyChainsPlayer) {
            spookyChainsButton.backgroundColor = halloweenOrange
        } else if (player === thunderStormPlayer) {
            thunderStormButton.backgroundColor = halloweenOrange
        } else if (player === scaryScreamPlayer) {
            scaryScreamButton.backgroundColor = halloweenOrange
        } else if (player === zombieGroanPlayer) {
            zombieGroanButton.backgroundColor = halloweenOrange
        } else if (player === ghostBooPlayer) {
            ghostBooButton.backgroundColor = halloweenOrange
        } else if (player === wereWolfHowlPlayer) {
            werewolfHowlButton.backgroundColor = halloweenOrange
        } else if (player === poltergeistVoicePlayer) {
            poltergeistVoiceButton.backgroundColor = halloweenOrange
        } else if (player === zombieCallPlayer) {
            zombieCallButton.backgroundColor = halloweenOrange
        } else if (player === catScreamPlayer) {
            catScreamButton.backgroundColor = halloweenOrange
        } else if (player === wraithWailPlayer) {
            wraithWailButton.backgroundColor = halloweenOrange
        } else if (player === spookyOwlPlayer) {
            spookyOwlButton.backgroundColor = halloweenOrange
        } else if (player === chainedGhoulPlayer) {
            chainedGhoulButton.backgroundColor = halloweenOrange
        } else if (player === hauntedOrganPlayer) {
            hauntedOrganButton.backgroundColor = halloweenOrange
        } else if (player === scareCrowPlayer) {
            scarecrowButton.backgroundColor = halloweenOrange
        } else if (player === blowingWindPlayer) {
            blowingWindButton.backgroundColor = halloweenOrange
        } else if (player === ghostlyWhisperPlayer) {
            ghostlyWhisperButton.backgroundColor = halloweenOrange
        } else if (player === draculaLaughPlayer) {
            draculaLaughButton.backgroundColor = halloweenOrange
        } else if (player === wolfCryPlayer) {
            wolfCryButton.backgroundColor = halloweenOrange
        } else if (player === knockKnockPlayer) {
            knockKnockButton.backgroundColor = halloweenOrange
        } else if (player === igorGrumblePlayer) {
            igorGrumbleButton.backgroundColor = halloweenOrange
        } else if (player === horrorMoviePlayer) {
            horrorMovieButton.backgroundColor = halloweenOrange
        } else if (player === warningBellsPlayer) {
            warningBellsButton.backgroundColor = halloweenOrange
        } else if (player === painfulMoanPlayer) {
            painfulMoanButton.backgroundColor = halloweenOrange
        } else if (player === witchesCauldronPlayer) {
            witchesCauldronButton.backgroundColor = halloweenOrange
        } else if (player === ghostlyChildrenPlayer) {
            ghostlyChildrenButton.backgroundColor = halloweenOrange
        } else if (player === hauntedSwampPlayer) {
            hauntedSwampButton.backgroundColor = halloweenOrange
        } else if (player === torturedSoulsPlayer) {
            torturedSoulsButton.backgroundColor = halloweenOrange
        } else if (player === chillingHornPlayer) {
            chillingHornButton.backgroundColor = halloweenOrange
        }
    }
    
}
