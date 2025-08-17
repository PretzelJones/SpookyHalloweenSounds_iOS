//
//  SeekableAudioButton.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/6/25.
//

import UIKit

class SeekableAudioButton: UIButton {
    // Progress value from 0.0 (none) to 1.0 (full)
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // Use the global halloweenDarkOrange color
    var progressColor: UIColor = halloweenDarkOrange

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard progress > 0 else { return }

        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()

            // Progress bar as a rounded rectangle
            let progressRect = CGRect(
                x: 0,
                y: 0,
                width: rect.width * progress,
                height: rect.height
            )

            let path = UIBezierPath(roundedRect: progressRect, cornerRadius: rect.height / 2)
            progressColor.setFill()
            path.fill()

            context.restoreGState()
        }
    }
}
