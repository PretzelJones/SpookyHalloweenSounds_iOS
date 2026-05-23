//
//  Theme.swift
//  SpookyHalloweenSounds
//

import SwiftUI

enum Theme {

    // MARK: - Colors (SwiftUI)
    static let orange        = Color(red: 243/255, green: 127/255, blue:  54/255)
    static let orangeLight   = Color(red: 245/255, green: 154/255, blue:  75/255)
    static let burntOrange   = Color(red: 200/255, green:  75/255, blue:  18/255)
    static let deepPurple    = Color(red:  52/255, green:  12/255, blue:  78/255)
    static let midPurple     = Color(red:  72/255, green:  22/255, blue: 100/255)
    static let nearBlack     = Color(red:   8/255, green:   4/255, blue:  14/255)

    // MARK: - Mesh Gradient (iOS 18+), 3x3 grid
    // Layout (row-major):
    //   nearBlack   deepPurple   nearBlack
    //   deepPurple  midPurple    burntOrange
    //   nearBlack   deepPurple   orange
    static let meshColors: [Color] = [
        nearBlack,  deepPurple,  nearBlack,
        deepPurple, midPurple,   burntOrange,
        nearBlack,  deepPurple,  orange,
    ]

    static let meshPoints: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
    ]
}
