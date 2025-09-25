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
            navigationItem.leftBarButtonItem = backItem
        }
        
        if let rightItem = navigationItem.rightBarButtonItem {
            if let keyImg = UIImage(named: "key")?.withRenderingMode(.alwaysTemplate) {
                rightItem.image = keyImg
                rightItem.tintColor = halloweenOrange
            }
        }

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
}

        /*
        // Get the build date string from Info.plist
        if let buildDateStr = Bundle.main.infoDictionary?["BuildDate"] as? String {
            // Create a DateFormatter to match the format used in the build script
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Parse the build date string into a Date object
            if let buildDate = dateFormatter.date(from: buildDateStr) {
                // Format the Date object to your desired output format
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd MMM yyyy" // Desired format: 25 Oct 2024
                let formattedBuildDate = outputFormatter.string(from: buildDate)
                
                //versionLabel.text = "Version \(appVersion) (\(buildNumber)) - Built on: \(formattedBuildDate)"
                versionLabel.text = "Version \(appVersion) (\(buildNumber)) - \(formattedBuildDate)"
            } else {
                versionLabel.text = "Version \(appVersion) (\(buildNumber)) - Built on: Invalid build date"
            }
        } else {
            versionLabel.text = "Version \(appVersion) (\(buildNumber)) - Built on: Unknown date"
        }
    }
         
}
*/
