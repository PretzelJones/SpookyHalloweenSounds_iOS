//
//  SeekButton.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/7/25.
//

import UIKit

final class SeekButton: UIButton {

    // MARK: Public
    weak var player: AudioSeekable? {
        didSet { setNeedsDisplay() }
    }

    /// Darker orange progress fill
    var progressFillColor: UIColor = UIColor(red: 0.85, green: 0.35, blue: 0.0, alpha: 1.0)

    // MARK: Private
    private var displayLink: CADisplayLink?
    private var wasPlayingBeforeScrub = false
    private var isScrubbing = false

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isOpaque = false
        contentMode = .redraw

        // Long‑press to enter scrub mode
        let lp = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        lp.minimumPressDuration = 0.2
        lp.allowableMovement = 12
        lp.cancelsTouchesInView = true   // once scrubbing starts, we own the touch
        addGestureRecognizer(lp)

        // Smooth progress updates while playing
        let link = CADisplayLink(target: self, selector: #selector(tick))
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    deinit { displayLink?.invalidate() }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

    // MARK: Drawing
    override func draw(_ rect: CGRect) {
        guard let p = player, p.duration > 0 else { return }

        var frac = CGFloat(p.currentTime / p.duration)
        if !frac.isFinite { frac = 0 }
        let w = bounds.width * max(0, min(1, frac))
        if w <= 0 { return }

        // Draw one continuous bar from the far left, behind image/title
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(progressFillColor.cgColor)
        ctx.fill(CGRect(x: 0, y: 0, width: w, height: bounds.height))
    }



    // MARK: Updates
    @objc private func tick() {
        guard !isScrubbing else { return }
        setNeedsDisplay()
    }

    // MARK: Scrubbing
    @objc private func handleLongPress(_ g: UILongPressGestureRecognizer) {
        guard let p = player, p.duration > 0 else { return }

        let x = g.location(in: self).x
        let clampedX = max(0, min(bounds.width, x))
        // Seek uses FULL button width (visuals don't affect math)
        let fraction = bounds.width > 0 ? clampedX / bounds.width : 0
        let newTime = Double(fraction) * p.duration

        switch g.state {
        case .began:
            isScrubbing = true
            wasPlayingBeforeScrub = p.isPlaying
            p.pause()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()

        case .changed:
            p.currentTime = newTime
            setNeedsDisplay()

        case .ended, .cancelled, .failed:
            p.currentTime = newTime
            if wasPlayingBeforeScrub { _ = p.play() }
            isScrubbing = false
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            setNeedsDisplay()

        default:
            break
        }
    }
}
