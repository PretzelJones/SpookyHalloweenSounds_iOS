//
//  AppDelegate.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/26/18.
//  Copyright © 2018 Bosson Design. All rights reserved.
//

//
//  AppDelegate.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/26/18.
//  Copyright © 2018 Bosson Design. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // ADDED: Track which players were playing so we can resume them cleanly on foreground/interruption end.
    private var playersToResume = Set<ObjectIdentifier>()
    
    internal func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // This will clear UserDefaults data. Use this ONLY for testing.
        //#if DEBUG
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
        //#endif
        
        #if DEBUG
        if CommandLine.arguments.contains("-resetNewFeatureFlag") {
            FirstRunGate.reset(key: FeatureFlags.newFeatureV1Seen)
        }
        #endif

        //code for lock screen controls
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            // ADDED: Activate session at launch so background/return-to-foreground starts from a good state.
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("Setting category/activation failed: \(error)")
        }
        // Other project setup
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //used for Firebase Messaging
        //        Messaging.messaging().delegate = self as? MessagingDelegate
        
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  Font: \(name)")
            }
        }

        //set navbar font
        if let customFont = UIFont(name: "Creepster-Regular", size: 30) {
            let appearance = UINavigationBar.appearance()
            appearance.titleTextAttributes = [
                .font: customFont,
                .foregroundColor: halloweenOrange // or whatever your theme uses
            ]
            appearance.tintColor = UIColor.orange
            appearance.backIndicatorImage = UIImage(named: "back-arrow")
            appearance.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
        }

        //keep screen on
        UIApplication.shared.isIdleTimerDisabled = true
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        //end of Firebase Messaging code
        
        // ADDED: Listen for app foreground/background + audio interruptions/route changes.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption(_:)),
                                               name: AVAudioSession.interruptionNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRouteChange(_:)),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: nil)
        
        return true
    }
    
    ////    used for Firebase Messaging
    //        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    //            print("Firebase registration token: \(fcmToken)")
    //
    //            let dataDict:[String: String] = ["token": fcmToken]
    //            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    //            // TODO: If necessary send token to application server.
    //            // Note: This callback is fired at each app startup and whenever a new token is generated.
    //        }
    //
    //        //used for Firebase Messaging
    //        private func application(application: UIApplication,
    //                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //            Messaging.messaging().apnsToken = deviceToken
    //        }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    
    // MARK: - ADDED: Foreground/Background handlers
    
    // ADDED: When app goes to background, remember which players were playing and pause them.
    @objc private func appDidEnterBackground() {
        for player in allPlayers() where player.isPlaying {
            playersToResume.insert(ObjectIdentifier(player))
            player.pause()
        }
    }
    
    // ADDED: On foreground, reactivate session and resume any players that were previously playing.
    @objc private func appDidBecomeActive() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("AVAudioSession re-activate failed: \(error)")
        }
        
        // Resume what we paused (and nudge any 'silent-but-playing' players)
        for player in allPlayers() {
            let id = ObjectIdentifier(player)
            if playersToResume.contains(id) {
                player.prepareToPlay()
                player.play()
            } else if player.isPlaying && player.volume == 0 {
                // Safety: if a player thinks it's playing but is silent, toggle it.
                player.pause()
                player.prepareToPlay()
                player.play()
            }
        }
        playersToResume.removeAll()
    }
    
    // MARK: - ADDED: Interruption & Route Change
    
    // ADDED: Handle audio interruptions (phone calls, Siri, etc.)
    @objc private func handleInterruption(_ note: Notification) {
        guard let info = note.userInfo,
              let rawType = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: rawType) else { return }
        
        switch type {
        case .began:
            // Snapshot who was playing when the interruption began.
            for p in allPlayers() where p.isPlaying {
                playersToResume.insert(ObjectIdentifier(p))
            }
        case .ended:
            let session = AVAudioSession.sharedInstance()
            do { try session.setActive(true) } catch {
                print("Failed to reactivate after interruption: \(error)")
            }
            // Resume anything we marked
            for p in allPlayers() where playersToResume.contains(ObjectIdentifier(p)) {
                p.prepareToPlay()
                p.play()
            }
            playersToResume.removeAll()
        @unknown default:
            break
        }
    }
    
    // ADDED: Keep session healthy across route changes (e.g., headphones unplugged).
    @objc private func handleRouteChange(_ note: Notification) {
        guard let info = note.userInfo,
              let rawReason = info[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: rawReason) else { return }
        
        if reason == .oldDeviceUnavailable || reason == .categoryChange || reason == .routeConfigurationChange {
            do { try AVAudioSession.sharedInstance().setActive(true) } catch { }
        }
    }
    
    // MARK: - ADDED: Utility to gather all players used across VCs
    // NOTE: These dictionaries are declared at file scope in your VCs.
    private func allPlayers() -> [AVAudioPlayer] {
        var arr: [AVAudioPlayer] = []
        arr.append(contentsOf: audioPlayers.values)            // ViewController buttons
        arr.append(contentsOf: longMixAudioPlayers.values)     // LongMix
        arr.append(contentsOf: horrorMovieAudioPlayers.values) // HorrorMovie
        arr.append(contentsOf: partyAudioPlayers.values)       // Party/Kids songs
        return arr
    }
}


/*
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // This will clear UserDefaults data. Use this ONLY for testing.
        //#if DEBUG
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
        //#endif
        
        #if DEBUG
        if CommandLine.arguments.contains("-resetNewFeatureFlag") {
            FirstRunGate.reset(key: FeatureFlags.newFeatureV1Seen)
        }
        #endif

        //code for lock screen controls
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        } catch let error as NSError {
            print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
        }
        // Other project setup
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //used for Firebase Messaging
        //        Messaging.messaging().delegate = self as? MessagingDelegate
        
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  Font: \(name)")
            }
        }

        //set navbar font
        if let customFont = UIFont(name: "Creepster-Regular", size: 30) {
            let appearance = UINavigationBar.appearance()
            appearance.titleTextAttributes = [
                .font: customFont,
                .foregroundColor: halloweenOrange // or whatever your theme uses
            ]
            appearance.tintColor = UIColor.orange
            appearance.backIndicatorImage = UIImage(named: "back-arrow")
            appearance.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
        }

        //keep screen on
        UIApplication.shared.isIdleTimerDisabled = true
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        //end of Firebase Messaging code
        
        return true
    }
    
////    used for Firebase Messaging
//        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//            print("Firebase registration token: \(fcmToken)")
//
//            let dataDict:[String: String] = ["token": fcmToken]
//            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//            // TODO: If necessary send token to application server.
//            // Note: This callback is fired at each app startup and whenever a new token is generated.
//        }
//
//        //used for Firebase Messaging
//        private func application(application: UIApplication,
//                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//            Messaging.messaging().apnsToken = deviceToken
//        }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
*/
