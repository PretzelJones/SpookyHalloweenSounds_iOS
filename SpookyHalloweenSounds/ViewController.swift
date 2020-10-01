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
    
    @IBOutlet weak var daysLabel: UILabel!
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
       
    var Halloween: Date {
           let currentYear = Date()
           let userCalendar = Calendar.current
           var components = DateComponents()
           components.year = userCalendar.component(.year, from: currentYear)
           components.day = 31
           components.month = 10

           return userCalendar.date(from: components)!
       }

       var today: Date {
           let now = Date()
           let userCalendar = Calendar.current
           var components = DateComponents()
           components.year = userCalendar.component(.year, from: now)
           components.day = userCalendar.component(.day, from: now)
           components.month = userCalendar.component(.month, from: now)

           return userCalendar.date(from: components)!
    }

    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let daysTillHalloween = daysBetweenDates(startDate: today, endDate: Halloween)
        daysLabel.text = "\(daysTillHalloween) days till Halloween"

//        UIApplication.shared.applicationIconBadgeNumber = daysTillHalloween
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        
        let arrowImage = UIImage(named: "left_arrow")
        self.navigationController?.navigationBar.backIndicatorImage = arrowImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = arrowImage
        self.navigationController?.navigationBar.backItem?.title = "Custom"
        
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
        loopingMixButton.haptic(loopingMixButton)
    }
    
    @IBAction func horrorThemePlay(_ sender: Any) {
        
        horrorThemeButton.pulsate(horrorThemeButton)
        horrorThemeButton.haptic(horrorThemeButton)
    }
    
    @IBAction func witchCacklePlay(_ sender: UIButton) {
        
        witchCackleButton.pulsate(witchCackleButton)
        witchCackleButton.haptic(witchCackleButton)
        witchCackleButton.showsTouchWhenHighlighted = true
        
        if (witchCacklePlayer!.isPlaying)
        {
            witchCacklePlayer?.delegate = self
            witchCacklePlayer!.pause();
            witchCackleButton.backgroundColor = halloweenOrange
            witchCackleButton.setImage(UIImage(named: "witch"), for: .normal)
            
        }
        else
        {
            witchCacklePlayer?.delegate = self
            witchCacklePlayer!.play();
            witchCackleButton.backgroundColor = halloweenOrangeHighlight
            witchCackleButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func blackCatPlay(_ sender: Any) {
        
        blackCatButton.pulsate(blackCatButton)
        blackCatButton.haptic(blackCatButton)
        blackCatButton.showsTouchWhenHighlighted = true
        
        if (blackCatPlayer!.isPlaying)
        {
            blackCatPlayer?.delegate = self
            blackCatPlayer!.pause();
            blackCatButton.backgroundColor = halloweenOrange
            blackCatButton.setImage(UIImage(named: "black_cat"), for: .normal)
            
        }
        else
        {
            blackCatPlayer?.delegate = self
            blackCatPlayer!.play();
            blackCatButton.backgroundColor = halloweenOrangeHighlight
            blackCatButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func creepyLaughPlay(_ sender: Any) {
        
        creepyLaughButton.pulsate(creepyLaughButton)
        creepyLaughButton.haptic(creepyLaughButton)
        creepyLaughButton.showsTouchWhenHighlighted = true
        
        if (creepyLaughPlayer!.isPlaying)
        {
            creepyLaughPlayer?.delegate = self
            creepyLaughPlayer!.pause();
            creepyLaughButton.backgroundColor = halloweenOrange
            creepyLaughButton.setImage(UIImage(named: "evil_man"), for: .normal)
            
        }
        else
        {
            creepyLaughPlayer?.delegate = self
            creepyLaughPlayer!.play();
            creepyLaughButton.backgroundColor = halloweenOrangeHighlight
            creepyLaughButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func horrorAmbiancePlay(_ sender: Any) {
        
        horrorAmbianceButton.pulsate(horrorAmbianceButton)
        horrorAmbianceButton.haptic(horrorAmbianceButton)
        horrorAmbianceButton.showsTouchWhenHighlighted = true
        
        if (horrorAmbiancePlayer!.isPlaying)
        {
            horrorAmbiancePlayer?.delegate = self
            horrorAmbiancePlayer!.pause();
            horrorAmbianceButton.backgroundColor = halloweenOrange
            horrorAmbianceButton.setImage(UIImage(named: "spider"), for: .normal)
            
        }
        else
        {
            horrorAmbiancePlayer?.delegate = self
            horrorAmbiancePlayer!.play();
            horrorAmbianceButton.backgroundColor = halloweenOrangeHighlight
            horrorAmbianceButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func monsterGrowlPlay(_ sender: Any) {
        
        monsterGrowlButton.pulsate(monsterGrowlButton)
        monsterGrowlButton.haptic(monsterGrowlButton)
        monsterGrowlButton.showsTouchWhenHighlighted = true
        
        if (monsterGrowlPlayer!.isPlaying)
        {
            monsterGrowlPlayer?.delegate = self
            monsterGrowlPlayer!.pause();
            monsterGrowlButton.backgroundColor = halloweenOrange
            monsterGrowlButton.setImage(UIImage(named: "monster_growl"), for: .normal)
            
        }
        else
        {
            monsterGrowlPlayer?.delegate = self
            monsterGrowlPlayer!.play();
            monsterGrowlButton.backgroundColor = halloweenOrangeHighlight
            monsterGrowlButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func monsterWalkingPlay(_ sender: Any) {
        
        monsterWalkingButton.pulsate(monsterWalkingButton)
        monsterWalkingButton.haptic(monsterWalkingButton)
        monsterWalkingButton.showsTouchWhenHighlighted = true
        
        if (monsterWalkingPlayer!.isPlaying)
        {
            monsterWalkingPlayer?.delegate = self
            monsterWalkingPlayer!.pause();
            monsterWalkingButton.backgroundColor = halloweenOrange
            monsterWalkingButton.setImage(UIImage(named: "monster_walking"), for: .normal)
            
        }
        else
        {
            monsterWalkingPlayer?.delegate = self
            monsterWalkingPlayer!.play();
            monsterWalkingButton.backgroundColor = halloweenOrangeHighlight
            monsterWalkingButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func creakyDoorPlay(_ sender: Any) {
        
        creakyDoorButton.pulsate(creakyDoorButton)
        creakyDoorButton.haptic(creakyDoorButton)
        creakyDoorButton.showsTouchWhenHighlighted = true
        
        if (creakyDoorPlayer!.isPlaying)
        {
            creakyDoorPlayer?.delegate = self
            creakyDoorPlayer!.pause();
            creakyDoorButton.backgroundColor = halloweenOrange
            creakyDoorButton.setImage(UIImage(named: "creaky_door"), for: .normal)
            
        }
        else
        {
            creakyDoorPlayer?.delegate = self
            creakyDoorPlayer!.play();
            creakyDoorButton.backgroundColor = halloweenOrangeHighlight
            creakyDoorButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func spookyChainsPlay(_ sender: Any) {
        
        spookyChainsButton.pulsate(spookyChainsButton)
        spookyChainsButton.haptic(spookyChainsButton)
        spookyChainsButton.showsTouchWhenHighlighted = true
        
        if (spookyChainsPlayer!.isPlaying)
        {
            spookyChainsPlayer?.delegate = self
            spookyChainsPlayer!.pause();
            spookyChainsButton.backgroundColor = halloweenOrange
            spookyChainsButton.setImage(UIImage(named: "chains"), for: .normal)
            
        }
        else
        {
            spookyChainsPlayer?.delegate = self
            spookyChainsPlayer!.play();
            spookyChainsButton.backgroundColor = halloweenOrangeHighlight
            spookyChainsButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func thunderStormPlay(_ sender: Any) {
        
        thunderStormButton.pulsate(thunderStormButton)
        thunderStormButton.haptic(thunderStormButton)
        thunderStormButton.showsTouchWhenHighlighted = true
        
        if (thunderStormPlayer!.isPlaying)
        {
            thunderStormPlayer?.delegate = self
            thunderStormPlayer!.pause();
            thunderStormButton.backgroundColor = halloweenOrange
            thunderStormButton.setImage(UIImage(named: "thunder"), for: .normal)
            
        }
        else
        {
            thunderStormPlayer?.delegate = self
            thunderStormPlayer!.play();
            thunderStormButton.backgroundColor = halloweenOrangeHighlight
            thunderStormButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func scaryScreamPlay(_ sender: Any) {
        
        scaryScreamButton.pulsate(scaryScreamButton)
        scaryScreamButton.haptic(scaryScreamButton)
        scaryScreamButton.showsTouchWhenHighlighted = true
        
        if (scaryScreamPlayer!.isPlaying)
        {
            scaryScreamPlayer?.delegate = self
            scaryScreamPlayer!.pause();
            scaryScreamButton.backgroundColor = halloweenOrange
            scaryScreamButton.setImage(UIImage(named: "scream"), for: .normal)
            
        }
        else
        {
            scaryScreamPlayer?.delegate = self
            scaryScreamPlayer!.play();
            scaryScreamButton.backgroundColor = halloweenOrangeHighlight
            scaryScreamButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func zombieGroanPlay(_ sender: Any) {
        
        zombieGroanButton.pulsate(zombieGroanButton)
        zombieGroanButton.haptic(zombieGroanButton)
        zombieGroanButton.showsTouchWhenHighlighted = true
        
        if (zombieGroanPlayer!.isPlaying)
        {
            zombieGroanPlayer?.delegate = self
            zombieGroanPlayer!.pause();
            zombieGroanButton.backgroundColor = halloweenOrange
            zombieGroanButton.setImage(UIImage(named: "zombie"), for: .normal)
            
        }
        else
        {
            zombieGroanPlayer?.delegate = self
            zombieGroanPlayer!.play();
            zombieGroanButton.backgroundColor = halloweenOrangeHighlight
            zombieGroanButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func ghostBooPlay(_ sender: Any) {
        
        ghostBooButton.pulsate(ghostBooButton)
        ghostBooButton.haptic(ghostBooButton)
        ghostBooButton.showsTouchWhenHighlighted = true
        
        if (ghostBooPlayer!.isPlaying)
        {
            ghostBooPlayer?.delegate = self
            ghostBooPlayer!.pause();
            ghostBooButton.backgroundColor = halloweenOrange
            ghostBooButton.setImage(UIImage(named: "ghost_boo"), for: .normal)
            
        }
        else
        {
            ghostBooPlayer?.delegate = self
            ghostBooPlayer!.play();
            ghostBooButton.backgroundColor = halloweenOrangeHighlight
            ghostBooButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func wereWolfHowlPlay(_ sender: Any) {
        
        werewolfHowlButton.pulsate(werewolfHowlButton)
        werewolfHowlButton.haptic(werewolfHowlButton)
        werewolfHowlButton.showsTouchWhenHighlighted = true
        
        if (wereWolfHowlPlayer!.isPlaying)
        {
            wereWolfHowlPlayer?.delegate = self
            wereWolfHowlPlayer!.pause();
            werewolfHowlButton.backgroundColor = halloweenOrange
            werewolfHowlButton.setImage(UIImage(named: "werewolf"), for: .normal)
            
        }
        else
        {
            wereWolfHowlPlayer?.delegate = self
            wereWolfHowlPlayer!.play();
            werewolfHowlButton.backgroundColor = halloweenOrangeHighlight
            werewolfHowlButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func poltergeistVoicePlay(_ sender: Any) {
        
        poltergeistVoiceButton.pulsate(poltergeistVoiceButton)
        poltergeistVoiceButton.haptic(poltergeistVoiceButton)
        poltergeistVoiceButton.showsTouchWhenHighlighted = true
        
        if (poltergeistVoicePlayer!.isPlaying)
        {
            poltergeistVoicePlayer?.delegate = self
            poltergeistVoicePlayer!.pause();
            poltergeistVoiceButton.backgroundColor = halloweenOrange
            poltergeistVoiceButton.setImage(UIImage(named: "poltergeist_tv"), for: .normal)
            
        }
        else
        {
            poltergeistVoicePlayer?.delegate = self
            poltergeistVoicePlayer!.play();
            poltergeistVoiceButton.backgroundColor = halloweenOrangeHighlight
            poltergeistVoiceButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func zombieCallPlay(_ sender: Any) {
        
        zombieCallButton.pulsate(zombieCallButton)
        zombieCallButton.haptic(zombieCallButton)
        zombieCallButton.showsTouchWhenHighlighted = true
        
        if (zombieCallPlayer!.isPlaying)
        {
            zombieCallPlayer?.delegate = self
            zombieCallPlayer!.pause();
            zombieCallButton.backgroundColor = halloweenOrange
            zombieCallButton.setImage(UIImage(named: "zombie_call"), for: .normal)
            
        }
        else
        {
            zombieCallPlayer?.delegate = self
            zombieCallPlayer!.play();
            zombieCallButton.backgroundColor = halloweenOrangeHighlight
            zombieCallButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func catScreamPlay(_ sender: Any) {
        
        catScreamButton.pulsate(catScreamButton)
        catScreamButton.haptic(catScreamButton)
        catScreamButton.showsTouchWhenHighlighted = true
        
        if (catScreamPlayer!.isPlaying)
        {
            catScreamPlayer?.delegate = self
            catScreamPlayer!.pause();
            catScreamButton.backgroundColor = halloweenOrange
            catScreamButton.setImage(UIImage(named: "cat_scream"), for: .normal)
            
        }
        else
        {
            catScreamPlayer?.delegate = self
            catScreamPlayer!.play();
            catScreamButton.backgroundColor = halloweenOrangeHighlight
            catScreamButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func wraithWailPlay(_ sender: Any) {
        
        wraithWailButton.pulsate(wraithWailButton)
        wraithWailButton.haptic(wraithWailButton)
        wraithWailButton.showsTouchWhenHighlighted = true
        
        if (wraithWailPlayer!.isPlaying)
        {
            wraithWailPlayer?.delegate = self
            wraithWailPlayer!.pause();
            wraithWailButton.backgroundColor = halloweenOrange
            wraithWailButton.setImage(UIImage(named: "wraith_wail"), for: .normal)
            
        }
        else
        {
            wraithWailPlayer?.delegate = self
            wraithWailPlayer!.play();
            wraithWailButton.backgroundColor = halloweenOrangeHighlight
            wraithWailButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func spookyOwlPlay(_ sender: Any) {
        
        spookyOwlButton.pulsate(spookyOwlButton)
        spookyOwlButton.haptic(spookyOwlButton)
        spookyOwlButton.showsTouchWhenHighlighted = true
        
        if (spookyOwlPlayer!.isPlaying)
        {
            spookyOwlPlayer?.delegate = self
            spookyOwlPlayer!.pause();
            spookyOwlButton.backgroundColor = halloweenOrange
            spookyOwlButton.setImage(UIImage(named: "spooky_owl"), for: .normal)
            
        }
        else
        {
            spookyOwlPlayer?.delegate = self
            spookyOwlPlayer!.play();
            spookyOwlButton.backgroundColor = halloweenOrangeHighlight
            spookyOwlButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func chainedGhoulPlay(_ sender: Any) {
        
        chainedGhoulButton.pulsate(chainedGhoulButton)
        chainedGhoulButton.haptic(chainedGhoulButton)
        chainedGhoulButton.showsTouchWhenHighlighted = true
        
        if (chainedGhoulPlayer!.isPlaying)
        {
            chainedGhoulPlayer?.delegate = self
            chainedGhoulPlayer!.pause();
            chainedGhoulButton.backgroundColor = halloweenOrange
            chainedGhoulButton.setImage(UIImage(named: "chained_ghoul"), for: .normal)
            
        }
        else
        {
            chainedGhoulPlayer?.delegate = self
            chainedGhoulPlayer!.play();
            chainedGhoulButton.backgroundColor = halloweenOrangeHighlight
            chainedGhoulButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func terrifiedScreamPlay(_ sender: Any) {
        
        terrifiedScreamButton.pulsate(terrifiedScreamButton)
        terrifiedScreamButton.haptic(terrifiedScreamButton)
        terrifiedScreamButton.showsTouchWhenHighlighted = true
        
        if (terrifiedScreamPlayer!.isPlaying)
        {
            terrifiedScreamPlayer?.delegate = self
            terrifiedScreamPlayer!.pause();
            terrifiedScreamButton.backgroundColor = halloweenOrange
            terrifiedScreamButton.setImage(UIImage(named: "terrified_scream"), for: .normal)
            
        }
        else
        {
            terrifiedScreamPlayer?.delegate = self
            terrifiedScreamPlayer!.play();
            terrifiedScreamButton.backgroundColor = halloweenOrangeHighlight
            terrifiedScreamButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func hauntedOrganPlay(_ sender: Any) {
        
        hauntedOrganButton.pulsate(hauntedOrganButton)
        hauntedOrganButton.haptic(hauntedOrganButton)
        hauntedOrganButton.showsTouchWhenHighlighted = true
        
        if (hauntedOrganPlayer!.isPlaying)
        {
            hauntedOrganPlayer?.delegate = self
            hauntedOrganPlayer!.pause();
            hauntedOrganButton.backgroundColor = halloweenOrange
            hauntedOrganButton.setImage(UIImage(named: "haunted_organ"), for: .normal)
            
        }
        else
        {
            hauntedOrganPlayer?.delegate = self
            hauntedOrganPlayer!.play();
            hauntedOrganButton.backgroundColor = halloweenOrangeHighlight
            hauntedOrganButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func scareCrowPlay(_ sender: Any) {
        
        scarecrowButton.pulsate(scarecrowButton)
        scarecrowButton.haptic(scarecrowButton)
        scarecrowButton.showsTouchWhenHighlighted = true
        
        if (scareCrowPlayer!.isPlaying)
        {
            scareCrowPlayer?.delegate = self
            scareCrowPlayer!.pause();
            scarecrowButton.backgroundColor = halloweenOrange
            scarecrowButton.setImage(UIImage(named: "scarecrow"), for: .normal)
            
        }
        else
        {
            scareCrowPlayer?.delegate = self
            scareCrowPlayer!.play();
            scarecrowButton.backgroundColor = halloweenOrangeHighlight
            scarecrowButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func blowingWindPlay(_ sender: Any) {
        
        blowingWindButton.pulsate(blowingWindButton)
        blowingWindButton.haptic(blowingWindButton)
        blowingWindButton.showsTouchWhenHighlighted = true
        
        if (blowingWindPlayer!.isPlaying)
        {
            blowingWindPlayer?.delegate = self
            blowingWindPlayer!.pause();
            blowingWindButton.backgroundColor = halloweenOrange
            blowingWindButton.setImage(UIImage(named: "blowing_wind"), for: .normal)
            
        }
        else
        {
            blowingWindPlayer?.delegate = self
            blowingWindPlayer!.play();
            blowingWindButton.backgroundColor = halloweenOrangeHighlight
            blowingWindButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func ghostlyWhisperPlay(_ sender: Any) {
        
        ghostlyWhisperButton.pulsate(ghostlyWhisperButton)
        ghostlyWhisperButton.haptic(ghostlyWhisperButton)
        ghostlyWhisperButton.showsTouchWhenHighlighted = true
        
        if (ghostlyWhisperPlayer!.isPlaying)
        {
            ghostlyWhisperPlayer?.delegate = self
            ghostlyWhisperPlayer!.pause();
            ghostlyWhisperButton.backgroundColor = halloweenOrange
            ghostlyWhisperButton.setImage(UIImage(named: "ghostly_whisper"), for: .normal)
            
        }
        else
        {
            ghostlyWhisperPlayer?.delegate = self
            ghostlyWhisperPlayer!.play();
            ghostlyWhisperButton.backgroundColor = halloweenOrangeHighlight
            ghostlyWhisperButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func draculaLaughPlay(_ sender: Any) {
        
        draculaLaughButton.pulsate(draculaLaughButton)
        draculaLaughButton.haptic(draculaLaughButton)
        draculaLaughButton.showsTouchWhenHighlighted = true
        
        if (draculaLaughPlayer!.isPlaying)
        {
            draculaLaughPlayer?.delegate = self
            draculaLaughPlayer!.pause();
            draculaLaughButton.backgroundColor = halloweenOrange
            draculaLaughButton.setImage(UIImage(named: "dracula_laugh"), for: .normal)
            
        }
        else
        {
            draculaLaughPlayer?.delegate = self
            draculaLaughPlayer!.play();
            draculaLaughButton.backgroundColor = halloweenOrangeHighlight
            draculaLaughButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func wolfCryPlay(_ sender: Any) {
        
        wolfCryButton.pulsate(wolfCryButton)
        wolfCryButton.haptic(wolfCryButton)
        wolfCryButton.showsTouchWhenHighlighted = true
        
        if (wolfCryPlayer!.isPlaying)
        {
            wolfCryPlayer?.delegate = self
            wolfCryPlayer!.pause();
            wolfCryButton.backgroundColor = halloweenOrange
            wolfCryButton.setImage(UIImage(named: "wolf"), for: .normal)
            
        }
        else
        {
            wolfCryPlayer?.delegate = self
            wolfCryPlayer!.play();
            wolfCryButton.backgroundColor = halloweenOrangeHighlight
            wolfCryButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func knockKnockPlay(_ sender: Any) {
        
        knockKnockButton.pulsate(knockKnockButton)
        knockKnockButton.haptic(knockKnockButton)
        knockKnockButton.showsTouchWhenHighlighted = true
        
        if (knockKnockPlayer!.isPlaying)
        {
            knockKnockPlayer?.delegate = self
            knockKnockPlayer!.pause();
            knockKnockButton.backgroundColor = halloweenOrange
            knockKnockButton.setImage(UIImage(named: "knock"), for: .normal)
            
        }
        else
        {
            knockKnockPlayer?.delegate = self
            knockKnockPlayer!.play();
            knockKnockButton.backgroundColor = halloweenOrangeHighlight
            knockKnockButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func igorGrumblePlay(_ sender: Any) {
        
        igorGrumbleButton.pulsate(igorGrumbleButton)
        igorGrumbleButton.haptic(igorGrumbleButton)
        igorGrumbleButton.showsTouchWhenHighlighted = true
        
        if (igorGrumblePlayer!.isPlaying)
        {
            igorGrumblePlayer?.delegate = self
            igorGrumblePlayer!.pause();
            igorGrumbleButton.backgroundColor = halloweenOrange
            igorGrumbleButton.setImage(UIImage(named: "igor"), for: .normal)
            
        }
        else
        {
            igorGrumblePlayer?.delegate = self
            igorGrumblePlayer!.play();
            igorGrumbleButton.backgroundColor = halloweenOrangeHighlight
            igorGrumbleButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func horrorMoviePlay(_ sender: Any) {
        
        horrorMovieButton.pulsate(horrorMovieButton)
        horrorMovieButton.haptic(horrorMovieButton)
        horrorMovieButton.showsTouchWhenHighlighted = true
        
        if (horrorMoviePlayer!.isPlaying)
        {
            horrorMoviePlayer?.delegate = self
            horrorMoviePlayer!.pause();
            horrorMovieButton.backgroundColor = halloweenOrange
            horrorMovieButton.setImage(UIImage(named: "film"), for: .normal)
            
        }
        else
        {
            horrorMoviePlayer?.delegate = self
            horrorMoviePlayer!.play();
            horrorMovieButton.backgroundColor = halloweenOrangeHighlight
            horrorMovieButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func warningBellsPlay(_ sender: Any) {
        
        warningBellsButton.pulsate(warningBellsButton)
        warningBellsButton.haptic(warningBellsButton)
        warningBellsButton.showsTouchWhenHighlighted = true
        
        if (warningBellsPlayer!.isPlaying)
        {
            warningBellsPlayer?.delegate = self
            warningBellsPlayer!.pause();
            warningBellsButton.backgroundColor = halloweenOrange
            warningBellsButton.setImage(UIImage(named: "warning_bells"), for: .normal)
            
        }
        else
        {
            warningBellsPlayer?.delegate = self
            warningBellsPlayer!.play();
            warningBellsButton.backgroundColor = halloweenOrangeHighlight
            warningBellsButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func painfulMoanPlay(_ sender: Any) {
        
        painfulMoanButton.pulsate(painfulMoanButton)
        painfulMoanButton.haptic(painfulMoanButton)
        painfulMoanButton.showsTouchWhenHighlighted = true
        
        if (painfulMoanPlayer!.isPlaying)
        {
            painfulMoanPlayer?.delegate = self
            painfulMoanPlayer!.pause();
            painfulMoanButton.backgroundColor = halloweenOrange
            painfulMoanButton.setImage(UIImage(named: "grave_stone"), for: .normal)
            
        }
        else
        {
            painfulMoanPlayer?.delegate = self
            painfulMoanPlayer!.play();
            painfulMoanButton.backgroundColor = halloweenOrangeHighlight
            painfulMoanButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func witchesCauldronPlay(_ sender: Any) {
        
        witchesCauldronButton.pulsate(witchesCauldronButton)
        witchesCauldronButton.haptic(witchesCauldronButton)
        witchesCauldronButton.showsTouchWhenHighlighted = true
        
        if (witchesCauldronPlayer!.isPlaying)
        {
            witchesCauldronPlayer?.delegate = self
            witchesCauldronPlayer!.pause();
            witchesCauldronButton.backgroundColor = halloweenOrange
            witchesCauldronButton.setImage(UIImage(named: "witches_cauldron"), for: .normal)
            
        }
        else
        {
            witchesCauldronPlayer?.delegate = self
            witchesCauldronPlayer!.play();
            witchesCauldronButton.backgroundColor = halloweenOrangeHighlight
            witchesCauldronButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func ghostlyChildrenPlay(_ sender: Any) {
        
        ghostlyChildrenButton.pulsate(ghostlyChildrenButton)
        ghostlyChildrenButton.haptic(ghostlyChildrenButton)
        ghostlyChildrenButton.showsTouchWhenHighlighted = true
        
        if (ghostlyChildrenPlayer!.isPlaying)
        {
            ghostlyChildrenPlayer?.delegate = self
            ghostlyChildrenPlayer!.pause();
            ghostlyChildrenButton.backgroundColor = halloweenOrange
            ghostlyChildrenButton.setImage(UIImage(named: "ghostly_children.jpg"), for: .normal)
            
        }
        else
        {
            ghostlyChildrenPlayer?.delegate = self
            ghostlyChildrenPlayer!.play();
            ghostlyChildrenButton.backgroundColor = halloweenOrangeHighlight
            ghostlyChildrenButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func hauntedSwampPlay(_ sender: Any) {
        
        hauntedSwampButton.pulsate(hauntedSwampButton)
        hauntedSwampButton.haptic(hauntedSwampButton)
        hauntedSwampButton.showsTouchWhenHighlighted = true
        
        if (hauntedSwampPlayer!.isPlaying)
        {
            hauntedSwampPlayer?.delegate = self
            hauntedSwampPlayer!.pause();
            hauntedSwampButton.backgroundColor = halloweenOrange
            hauntedSwampButton.setImage(UIImage(named: "haunted_swamp"), for: .normal)
            
        }
        else
        {
            hauntedSwampPlayer?.delegate = self
            hauntedSwampPlayer!.play();
            hauntedSwampButton.backgroundColor = halloweenOrangeHighlight
            hauntedSwampButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func torturedSoulsPlay(_ sender: Any) {
        
        torturedSoulsButton.pulsate(torturedSoulsButton)
        torturedSoulsButton.haptic(torturedSoulsButton)
        torturedSoulsButton.showsTouchWhenHighlighted = true
        
        if (torturedSoulsPlayer!.isPlaying)
        {
            torturedSoulsPlayer?.delegate = self
            torturedSoulsPlayer!.pause();
            torturedSoulsButton.backgroundColor = halloweenOrange
            torturedSoulsButton.setImage(UIImage(named: "tortured_souls"), for: .normal)
            
        }
        else
        {
            torturedSoulsPlayer?.delegate = self
            torturedSoulsPlayer!.play();
            torturedSoulsButton.backgroundColor = halloweenOrangeHighlight
            torturedSoulsButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func chillingHornPlay(_ sender: Any) {
        
        chillingHornButton.pulsate(chillingHornButton)
        chillingHornButton.haptic(chillingHornButton)
        chillingHornButton.showsTouchWhenHighlighted = true
        
        if (chillingHornPlayer!.isPlaying)
        {
            chillingHornPlayer?.delegate = self
            chillingHornPlayer!.pause();
            chillingHornButton.backgroundColor = halloweenOrange
            chillingHornButton.setImage(UIImage(named: "alien"), for: .normal)
            
        }
        else
        {
            chillingHornPlayer?.delegate = self
            chillingHornPlayer!.play();
            chillingHornButton.backgroundColor = halloweenOrangeHighlight
            chillingHornButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (player === witchCacklePlayer) {
            witchCackleButton.backgroundColor = halloweenOrange
            witchCackleButton.setImage(UIImage(named: "witch"), for: .normal)
            witchCackleButton.pulsate2(witchCackleButton)
        } else if (player === blackCatPlayer) {
            blackCatButton.backgroundColor = halloweenOrange
            blackCatButton.setImage(UIImage(named: "black_cat"), for: .normal)
            blackCatButton.pulsate2(blackCatButton)
        } else if (player === creepyLaughPlayer) {
            creepyLaughButton.backgroundColor = halloweenOrange
            creepyLaughButton.setImage(UIImage(named: "evil_man"), for: .normal)
            creepyLaughButton.pulsate2(creepyLaughButton)
        } else if (player === horrorAmbiancePlayer) {
            horrorAmbianceButton.backgroundColor = halloweenOrange
            horrorAmbianceButton.setImage(UIImage(named: "spider"), for: .normal)
            horrorAmbianceButton.pulsate2(horrorAmbianceButton)
        } else if (player === monsterGrowlPlayer) {
            monsterGrowlButton.backgroundColor = halloweenOrange
            monsterGrowlButton.setImage(UIImage(named: "monster_growl"), for: .normal)
            monsterGrowlButton.pulsate2(monsterGrowlButton)
        } else if (player === monsterWalkingPlayer) {
            monsterWalkingButton.backgroundColor = halloweenOrange
            monsterWalkingButton.setImage(UIImage(named: "monster_walking"), for: .normal)
            monsterWalkingButton.pulsate2(monsterWalkingButton)
        } else if (player === creakyDoorPlayer) {
            creakyDoorButton.backgroundColor = halloweenOrange
            creakyDoorButton.setImage(UIImage(named: "creaky_door"), for: .normal)
            creakyDoorButton.pulsate2(creakyDoorButton)
        } else if (player === spookyChainsPlayer) {
            spookyChainsButton.backgroundColor = halloweenOrange
            spookyChainsButton.setImage(UIImage(named: "chains"), for: .normal)
            spookyChainsButton.pulsate2(spookyChainsButton)
        } else if (player === thunderStormPlayer) {
            thunderStormButton.backgroundColor = halloweenOrange
            thunderStormButton.setImage(UIImage(named: "thunder"), for: .normal)
            thunderStormButton.pulsate2(thunderStormButton)
        } else if (player === scaryScreamPlayer) {
            scaryScreamButton.backgroundColor = halloweenOrange
            scaryScreamButton.setImage(UIImage(named: "scream"), for: .normal)
            scaryScreamButton.pulsate2(scaryScreamButton)
        } else if (player === zombieGroanPlayer) {
            zombieGroanButton.backgroundColor = halloweenOrange
            zombieGroanButton.setImage(UIImage(named: "zombie"), for: .normal)
            zombieGroanButton.pulsate2(zombieGroanButton)
        } else if (player === ghostBooPlayer) {
            ghostBooButton.backgroundColor = halloweenOrange
            ghostBooButton.setImage(UIImage(named: "ghost_boo"), for: .normal)
            ghostBooButton.pulsate2(ghostBooButton)
        } else if (player === wereWolfHowlPlayer) {
            werewolfHowlButton.backgroundColor = halloweenOrange
            werewolfHowlButton.setImage(UIImage(named: "werewolf"), for: .normal)
            werewolfHowlButton.pulsate2(werewolfHowlButton)
        } else if (player === poltergeistVoicePlayer) {
            poltergeistVoiceButton.backgroundColor = halloweenOrange
            poltergeistVoiceButton.setImage(UIImage(named: "poltergeist_tv"), for: .normal)
            poltergeistVoiceButton.pulsate2(poltergeistVoiceButton)
        } else if (player === zombieCallPlayer) {
            zombieCallButton.backgroundColor = halloweenOrange
            zombieCallButton.setImage(UIImage(named: "zombie_call"), for: .normal)
            zombieCallButton.pulsate2(zombieCallButton)
        } else if (player === catScreamPlayer) {
            catScreamButton.backgroundColor = halloweenOrange
            catScreamButton.setImage(UIImage(named: "cat_scream"), for: .normal)
            catScreamButton.pulsate2(catScreamButton)
        } else if (player === wraithWailPlayer) {
            wraithWailButton.backgroundColor = halloweenOrange
            wraithWailButton.setImage(UIImage(named: "wraith_wail"), for: .normal)
            wraithWailButton.pulsate2(wraithWailButton)
        } else if (player === spookyOwlPlayer) {
            spookyOwlButton.backgroundColor = halloweenOrange
            spookyOwlButton.setImage(UIImage(named: "spooky_owl"), for: .normal)
            spookyOwlButton.pulsate2(spookyOwlButton)
        } else if (player === chainedGhoulPlayer) {
            chainedGhoulButton.backgroundColor = halloweenOrange
            chainedGhoulButton.setImage(UIImage(named: "chained_ghoul"), for: .normal)
            chainedGhoulButton.pulsate2(chainedGhoulButton)
        }else if (player === terrifiedScreamPlayer) {
            terrifiedScreamButton.backgroundColor = halloweenOrange
            terrifiedScreamButton.setImage(UIImage(named: "terrified_scream"), for: .normal)
            terrifiedScreamButton.pulsate2(terrifiedScreamButton)
        } else if (player === hauntedOrganPlayer) {
            hauntedOrganButton.backgroundColor = halloweenOrange
            hauntedOrganButton.setImage(UIImage(named: "haunted_organ"), for: .normal)
            hauntedOrganButton.pulsate2(hauntedOrganButton)
        } else if (player === scareCrowPlayer) {
            scarecrowButton.backgroundColor = halloweenOrange
            scarecrowButton.setImage(UIImage(named: "scarecrow"), for: .normal)
            scarecrowButton.pulsate2(scarecrowButton)
        } else if (player === blowingWindPlayer) {
            blowingWindButton.backgroundColor = halloweenOrange
            blowingWindButton.setImage(UIImage(named: "blowing_wind"), for: .normal)
            blowingWindButton.pulsate2(blowingWindButton)
        } else if (player === ghostlyWhisperPlayer) {
            ghostlyWhisperButton.backgroundColor = halloweenOrange
            ghostlyWhisperButton.setImage(UIImage(named: "ghostly_whisper"), for: .normal)
            ghostlyWhisperButton.pulsate2(ghostlyWhisperButton)
        } else if (player === draculaLaughPlayer) {
            draculaLaughButton.backgroundColor = halloweenOrange
            draculaLaughButton.setImage(UIImage(named: "dracula_laugh"), for: .normal)
            draculaLaughButton.pulsate2(draculaLaughButton)
        } else if (player === wolfCryPlayer) {
            wolfCryButton.backgroundColor = halloweenOrange
            wolfCryButton.setImage(UIImage(named: "wolf"), for: .normal)
            wolfCryButton.pulsate2(wolfCryButton)
        } else if (player === knockKnockPlayer) {
            knockKnockButton.backgroundColor = halloweenOrange
            knockKnockButton.setImage(UIImage(named: "knock"), for: .normal)
            knockKnockButton.pulsate2(knockKnockButton)
        } else if (player === igorGrumblePlayer) {
            igorGrumbleButton.backgroundColor = halloweenOrange
            igorGrumbleButton.setImage(UIImage(named: "igor"), for: .normal)
            igorGrumbleButton.pulsate2(igorGrumbleButton)
        } else if (player === horrorMoviePlayer) {
            horrorMovieButton.backgroundColor = halloweenOrange
            horrorMovieButton.setImage(UIImage(named: "film"), for: .normal)
            horrorMovieButton.pulsate2(horrorMovieButton)
        } else if (player === warningBellsPlayer) {
            warningBellsButton.backgroundColor = halloweenOrange
            warningBellsButton.setImage(UIImage(named: "warning_bells"), for: .normal)
            warningBellsButton.pulsate2(warningBellsButton)
        } else if (player === painfulMoanPlayer) {
            painfulMoanButton.backgroundColor = halloweenOrange
            painfulMoanButton.setImage(UIImage(named: "grave_stone"), for: .normal)
            painfulMoanButton.pulsate2(painfulMoanButton)
        } else if (player === witchesCauldronPlayer) {
            witchesCauldronButton.backgroundColor = halloweenOrange
            witchesCauldronButton.setImage(UIImage(named: "witches_cauldron"), for: .normal)
            witchesCauldronButton.pulsate2(witchesCauldronButton)
        } else if (player === ghostlyChildrenPlayer) {
            ghostlyChildrenButton.backgroundColor = halloweenOrange
            ghostlyChildrenButton.setImage(UIImage(named: "ghostly_children.jpg"), for: .normal)
            ghostlyChildrenButton.pulsate2(ghostlyChildrenButton)
        } else if (player === hauntedSwampPlayer) {
            hauntedSwampButton.backgroundColor = halloweenOrange
            hauntedSwampButton.setImage(UIImage(named: "haunted_swamp"), for: .normal)
            hauntedSwampButton.pulsate2(hauntedSwampButton)
        } else if (player === torturedSoulsPlayer) {
            torturedSoulsButton.backgroundColor = halloweenOrange
            torturedSoulsButton.setImage(UIImage(named: "tortured_souls"), for: .normal)
            torturedSoulsButton.pulsate2(torturedSoulsButton)
        } else if (player === chillingHornPlayer) {
            chillingHornButton.backgroundColor = halloweenOrange
            chillingHornButton.setImage(UIImage(named: "alien"), for: .normal)
            chillingHornButton.pulsate2(chillingHornButton)
        }
    }

}


