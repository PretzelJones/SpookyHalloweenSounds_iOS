//
//  AudioSeekable.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/7/25.
//

import Foundation

public protocol AudioSeekable: AnyObject {
    var duration: TimeInterval { get }
    var currentTime: TimeInterval { get set }
    var isPlaying: Bool { get }

    @discardableResult
    func play() -> Bool
    func pause()
}

