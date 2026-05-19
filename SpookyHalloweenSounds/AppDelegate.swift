//
//  AppDelegate.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/26/18.
//  Copyright © 2018 Bosson Design. All rights reserved.
//


import UIKit
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
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print("AVAudioSession setup failed: \(error)")
        }

        let nav = UINavigationBarAppearance()
        nav.configureWithOpaqueBackground()
        nav.backgroundColor = .black

        if let f = UIFont(name: "Creepster-Regular", size: 30) {
            nav.titleTextAttributes = [
                .font: f,
                .foregroundColor: halloweenOrange
            ]
        }

        if let back = UIImage(named: "left_arrow") {
            nav.setBackIndicatorImage(back, transitionMaskImage: back)
        }

        // Hide back button text
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
            UIOffset(horizontal: -1000, vertical: 0), for: .default
        )

        // Remove glass backgrounds globally
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.backgroundImage = nil
        buttonAppearance.highlighted.backgroundImage = nil
        buttonAppearance.focused.backgroundImage = nil
        buttonAppearance.disabled.backgroundImage = nil

        nav.buttonAppearance = buttonAppearance
        nav.doneButtonAppearance = buttonAppearance
        nav.backButtonAppearance = buttonAppearance


        nav.buttonAppearance = buttonAppearance
        nav.doneButtonAppearance = buttonAppearance
        nav.backButtonAppearance = buttonAppearance

        // Apply tint + appearances
        UINavigationBar.appearance().tintColor = halloweenOrange
        UINavigationBar.appearance().standardAppearance = nav
        UINavigationBar.appearance().scrollEdgeAppearance = nav
        UINavigationBar.appearance().compactAppearance = nav

        //keep screen on
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
    
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

