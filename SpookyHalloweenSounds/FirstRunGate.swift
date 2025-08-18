//
//  FirstRunGate.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/17/25.
//

import Foundation

struct FirstRunGate {
    static func consumeOnce(key: String, defaults: UserDefaults = .standard) -> Bool {
        if defaults.bool(forKey: key) { return false }
        defaults.set(true, forKey: key)
        return true
    }

    #if DEBUG
    static func reset(key: String, defaults: UserDefaults = .standard) {
        defaults.removeObject(forKey: key)
    }
    #endif
}
