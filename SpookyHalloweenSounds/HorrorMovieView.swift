//
//  HorrorMovieView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation
import Observation

// MARK: - View Model

@Observable
final class HorrorMovieViewModel {

    struct Track: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let soundFile: String
    }

    let tracks: [Track] = [
        Track(id: 0, title: "Halloween",               imageName: "halloween",        soundFile: "halloween"),
        Track(id: 1, title: "The Exorcist",            imageName: "cross",            soundFile: "exorcist"),
        Track(id: 2, title: "The Shining",             imageName: "shining",          soundFile: "shining"),
        Track(id: 3, title: "Nightmare on Elm Street", imageName: "freddy",           soundFile: "elm_street"),
        Track(id: 4, title: "Friday the 13th",         imageName: "vorhees",          soundFile: "vorhees"),
        Track(id: 5, title: "Amityville Horror",       imageName: "amityville",       soundFile: "amityville"),
        Track(id: 6, title: "Unsolved Mysteries",      imageName: "question_mark",    soundFile: "unsolved_mysteries"),
        Track(id: 7, title: "X-Files",                 imageName: "magnifying_glass", soundFile: "xfiles"),
    ]

    var playingId: Int? = nil

    private var players: [Int: AVAudioPlayer] = [:]

    init() {
        for track in tracks {
            let file = track.soundFile
            let url = Bundle.main.url(forResource: file, withExtension: "mp3")
                   ?? Bundle.main.url(forResource: file, withExtension: "wav")
            guard let url else {
                print("HorrorMovie: file not found — \(file)")
                continue
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = -1
                players[track.id] = player
            } catch {
                print("HorrorMovie: failed to load \(file): \(error)")
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
            playingId = id
            coordinator.start(
                id: id, title: track.title, imageName: track.imageName,
                player: player,
                setPlaying: { [weak self] isPlaying in
                    self?.playingId = isPlaying ? id : nil
                }
            )
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

struct HorrorMovieView: View {
    @State private var model = HorrorMovieViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NowPlayingContainer {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    Text("Here lies a collection of some of the most famous theme songs from your favorite horror films. Enjoy!")
                        .font(.custom("Creepster", size: 20))
                        .foregroundStyle(Theme.orange)
                        .multilineTextAlignment(.center)
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    PaletteIconView(imageName: "left_arrow")
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    HorrorMovieView()
}
