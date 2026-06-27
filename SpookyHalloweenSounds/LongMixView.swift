//
//  LongMixView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation
import Observation

// MARK: - View Model

@Observable
final class LongMixViewModel {

    struct Track: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let soundFile: String
    }

    let tracks: [Track] = [
        Track(id: 0, title: "Ultra Terror",      imageName: "ultra_terror",   soundFile: "ultra_terror"),
        Track(id: 1, title: "Haunted House",     imageName: "haunted_circus", soundFile: "haunted_house"),
        Track(id: 2, title: "Spooky Sounds",     imageName: "spooky_sounds",  soundFile: "long_mix"),
        Track(id: 3, title: "Space Terror",      imageName: "space_terrors",  soundFile: "space_terror"),
        Track(id: 4, title: "Don't Let Them In", imageName: "key",            soundFile: "dont_let_in"),
    ]

    var playingId: Int? = nil

    private var players: [Int: AVAudioPlayer] = [:]

    init() {
        for track in tracks {
            let file = track.soundFile
            let url = Bundle.main.url(forResource: file, withExtension: "mp3")
                   ?? Bundle.main.url(forResource: file, withExtension: "wav")
            guard let url else {
                print("LongMix: file not found — \(file)")
                continue
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = -1
                players[track.id] = player
            } catch {
                print("LongMix: failed to load \(file): \(error)")
            }
        }
    }

    func toggle(id: Int) {
        let coordinator = NowPlayingCoordinator.shared
        if playingId == id {
            let player = players[id]
            player?.pause()
            if let player { coordinator.clearIfMatches(player) }
            playingId = nil
        } else {
            if let prev = playingId { players[prev]?.pause() }
            guard let player = players[id],
                  let track = tracks.first(where: { $0.id == id }) else { return }
            player.play()
            coordinator.start(
                id: id, title: track.title, imageName: track.imageName,
                player: player,
                setPlaying: { [weak self] isPlaying in
                    self?.playingId = isPlaying ? id : nil
                }
            )
            playingId = id
        }
    }

    func pauseAll() {
        guard let id = playingId else { return }
        let player = players[id]
        player?.pause()
        if let player { NowPlayingCoordinator.shared.clearIfMatches(player) }
        playingId = nil
    }
}

// MARK: - View

struct LongMixView: View {
    @State private var model = LongMixViewModel()

    var body: some View {
        NowPlayingContainer {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    PaletteText(text: "The looping sounds will continue to play indefinitely! Press a button a second time to pause, or press two or more to mix sounds together.", font: .custom("Creepster", size: 20), multiline: true)
                        .padding(.top, 8)
                        .padding(.horizontal, 4)

                    ForEach(model.tracks) { track in
                        GlassTile(
                            imageName: track.imageName,
                            title: track.title,
                            isPlaying: model.playingId == track.id
                        ) {
                            model.toggle(id: track.id)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .safeAreaInset(edge: .bottom) {
            MiniPlayerBarView()
        }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LongMixView()
}
