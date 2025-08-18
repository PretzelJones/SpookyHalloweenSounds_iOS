//
//  SeekableAudioButton.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 8/6/25.
//

import UIKit

// A custom view that acts as a button with an integrated seekable progress bar.
class SeekableButtonView: UIView {

    // MARK: - Properties

    // The view that represents the progress bar.
    private var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = halloweenDarkOrange // Use the darker orange from Colors.swift
        return view
    }()

    // The button that handles the main tap actions.
    let tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()

    // The current progress (a value from 0.0 to 1.0).
    var progress: CGFloat = 0.0 {
        didSet {
            // Update the width of the progress bar when the progress changes.
            self.setNeedsLayout()
        }
    }

    // A closure for when the user performs a seeking action.
    var seekAction: ((CGFloat) -> Void)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - View Setup

    private func setupView() {
        // Set the background color and rounded corners for the button appearance.
        self.backgroundColor = halloweenOrange // Use the light orange from Colors.swift
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

        // Add the progress bar and the button to the view.
        self.addSubview(progressBar)
        self.addSubview(tapButton)

        // Set up constraints for the button to fill the entire view.
        NSLayoutConstraint.activate([
            tapButton.topAnchor.constraint(equalTo: self.topAnchor),
            tapButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tapButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        // Add a long press gesture recognizer for seeking.
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5 // Adjust as needed
        self.addGestureRecognizer(longPressGesture)
    }

    // MARK: - Layout & Drawing

    override func layoutSubviews() {
        super.layoutSubviews()
        // Animate the progress bar's width.
        UIView.animate(withDuration: 0.1) {
            self.progressBar.frame = CGRect(x: 0, y: 0, width: self.bounds.width * self.progress, height: self.bounds.height)
        }
    }

    // MARK: - Gesture Handling

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self)
        var newProgress = location.x / self.bounds.width
        newProgress = min(1.0, max(0.0, newProgress)) // Clamp the value between 0 and 1.

        if gesture.state == .began || gesture.state == .changed {
            // Update the visual progress bar as the user slides their finger.
            self.progress = newProgress
        }

        if gesture.state == .ended {
            // When the user lifts their finger, perform the seek action.
            seekAction?(newProgress)
        }
    }
}
