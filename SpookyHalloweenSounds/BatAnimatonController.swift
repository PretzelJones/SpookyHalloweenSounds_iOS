//
//  BatAnimatonController.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 7/26/20.
//  Copyright © 2020 Bosson Design. All rights reserved.
//

import UIKit

/// Manages the life cycle of the slow flake animation
internal struct BatAnimationManager {
    
    fileprivate let batLayer = CAEmitterLayer()
    
    fileprivate lazy var batCell: CAEmitterCell = {
        let batCell = CAEmitterCell()
        batCell.contents = UIImage(named: "bat")?.cgImage
        batCell.scale = 0.06
        batCell.scaleRange = 0.3
        batCell.emissionRange = .pi
        batCell.lifetime = 20.0
        batCell.birthRate = 40
        batCell.velocity = -30
        batCell.velocityRange = -20
        batCell.yAcceleration = 30
        batCell.xAcceleration = 5
        batCell.spin = -0.5
        batCell.spinRange = 1.0
        return batCell
    }()
    
    /// Injects snow layer into view hierarchy
    ///
    /// - Parameter view: UIView to insert snow layer within
    mutating func injectSnowLayer(into view: UIView) {
        batLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        batLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        batLayer.emitterShape = CAEmitterLayerEmitterShape.line
        batLayer.beginTime = CACurrentMediaTime()
        batLayer.timeOffset = CFTimeInterval(arc4random_uniform(6) + 5)
        batLayer.emitterCells = [batCell]
        
        view.layer.addSublayer(batLayer)
    }
    
    /// Removes snow flake animation
    func removeFlake() {
        batLayer.removeFromSuperlayer()
    }
    
}

