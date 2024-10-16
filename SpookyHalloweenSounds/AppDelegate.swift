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
    
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // This will clear UserDefaults data. Use this ONLY for testing.
                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                UserDefaults.standard.synchronize()
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
