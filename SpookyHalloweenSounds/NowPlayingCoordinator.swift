//
//  NowPlayingCoordinator.swift
//  SpookyHalloweenSounds
//

import AVFoundation
import Observation

@Observable
final class NowPlayingCoordinator {

    static let shared = NowPlayingCoordinator()
    private init() {}

    struct Item {
        let id: Int
        let title: String
        let imageName: String
        let player: AVAudioPlayer
        // Tells the owning view model to update its playingId
        let setPlaying: (Bool) -> Void
    }

    var item: Item? = nil
    var isPlaying: Bool = false

    var isVisible: Bool { item != nil }
    var showExpanded: Bool = false

    // Called by a view model when it starts a track
    func start(id: Int, title: String, imageName: String,
               player: AVAudioPlayer, setPlaying: @escaping (Bool) -> Void) {
        if let existing = item, existing.player !== player {
            existing.player.pause()
            existing.setPlaying(false)
        }
        item = Item(id: id, title: title, imageName: imageName,
                    player: player, setPlaying: setPlaying)
        isPlaying = true
    }

    // Mini player play/pause button
    func togglePlayPause() {
        guard let item else { return }
        if isPlaying {
            item.player.pause()
            item.setPlaying(false)
            isPlaying = false
        } else {
            item.player.play()
            item.setPlaying(true)
            isPlaying = true
        }
    }

    // Stop button in expanded player
    func stop() {
        guard let item else { return }
        item.player.pause()
        item.player.currentTime = 0
        item.setPlaying(false)
        self.item = nil
        isPlaying = false
        showExpanded = false
    }

    // Called by a view model when it pauses a track from the tile
    func clearIfMatches(_ player: AVAudioPlayer) {
        guard item?.player === player else { return }
        item = nil
        isPlaying = false
    }

    func seek(to fraction: Double) {
        guard let item, item.player.duration > 0 else { return }
        item.player.currentTime = fraction * item.player.duration
    }
}
