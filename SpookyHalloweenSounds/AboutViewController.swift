//
//  AboutViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/6/19.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import UIKit
import Foundation

class AboutViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel! // Connect this to your label in storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the app version and build number from the Info.plist
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown version"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown build"
        
        if let buildDateStr = Bundle.main.infoDictionary?["BuildDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // must match the format from the build script
            
            if let buildDate = dateFormatter.date(from: buildDateStr) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd MMM yyyy"
                _ = outputFormatter.string(from: buildDate)
                
                versionLabel.text = "Version \(appVersion) (\(buildNumber))"
            } else {
                versionLabel.text = "Version \(appVersion) (\(buildNumber))"
            }
        } else {
            versionLabel.text = "Version \(appVersion) (\(buildNumber))"
        }
        
        // Custom back button
        navigationItem.hidesBackButton = true
        if let img = UIImage(named: "left_arrow")?.withRenderingMode(.alwaysTemplate) {
            let backItem = UIBarButtonItem(
                image: img,
                style: .plain,
                target: self,
                action: #selector(onBack)
            )
            backItem.tintColor = halloweenOrange
            if #available(iOS 26.0, *) {
                backItem.hidesSharedBackground = true
            } else {
                // Fallback on earlier versions
            } 
            navigationItem.leftBarButtonItem = backItem
        }
        
        if let rightItem = navigationItem.rightBarButtonItem {
            if let keyImg = UIImage(named: "key")?.withRenderingMode(.alwaysTemplate) {
                rightItem.image = keyImg
                rightItem.tintColor = halloweenOrange
                if #available(iOS 26.0, *) {
                    rightItem.hidesSharedBackground = true
                } else {
                    // Fallback on earlier versions
                }
            }
        }

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
}
