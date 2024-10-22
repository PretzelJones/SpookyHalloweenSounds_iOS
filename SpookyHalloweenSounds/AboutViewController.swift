//
//  AboutViewController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/6/19.
//  Copyright © 2019 Bosson Design. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel! // Connect this to your label in storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // Get the app version and build number from the Info.plist
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown version"
                let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown build"
                
                // Format the current date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let currentDate = dateFormatter.string(from: Date())
                
                // Set the label text to display version and date
                versionLabel.text = "Version \(appVersion) (\(buildNumber)) - \(currentDate)"
            }
    }

