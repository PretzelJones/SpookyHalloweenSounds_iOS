//
//  HiddenView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation
import Observation

// MARK: - View Model

@Observable
final class HiddenViewModel {

    struct Track: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let soundFile: String
    }

    let tracks: [Track] = [
        Track(id: 0, title: "The Ghost Song",  imageName: "ghost_song", soundFile: "the_ghost_song"),
        Track(id: 1, title: "The Old Tape",    imageName: "old_tape",   soundFile: "the_old_tape"),
        Track(id: 2, title: "Chilling Cries",  imageName: "dispair",    soundFile: "chilling_cries"),
        Track(id: 3, title: "Cries From Hell", imageName: "cries_hell", soundFile: "cries_from_hell"),
    ]

    var playingId: Int? = nil

    private var players: [Int: AVAudioPlayer] = [:]

    init() {
        for track in tracks {
            let file = track.soundFile
            let url = Bundle.main.url(forResource: file, withExtension: "mp3")
                   ?? Bundle.main.url(forResource: file, withExtension: "wav")
            guard let url else {
                print("Hidden: file not found — \(file)")
                continue
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = -1
                players[track.id] = player
            } catch {
                print("Hidden: failed to load \(file): \(error)")
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

struct HiddenView: View {
    @State private var model = HiddenViewModel()

    var body: some View {
        NowPlayingContainer {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    PaletteText(text: "Shh... you found the hidden sounds. These mysterious tracks were too eerie for the main stage.", font: .custom("Creepster", size: 20), multiline: true)
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
    HiddenView()
}
