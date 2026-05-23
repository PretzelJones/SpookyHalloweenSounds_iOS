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
        var isPlaying: Bool = false
    }

    var tracks: [Track] = [
        Track(id: 0, title: "Halloween",               imageName: "halloween",        soundFile: "halloween"),
        Track(id: 1, title: "The Exorcist",            imageName: "cross",            soundFile: "exorcist"),
        Track(id: 2, title: "The Shining",             imageName: "shining",          soundFile: "shining"),
        Track(id: 3, title: "Nightmare on Elm Street", imageName: "freddy",           soundFile: "elm_street"),
        Track(id: 4, title: "Friday the 13th",         imageName: "vorhees",          soundFile: "vorhees"),
        Track(id: 5, title: "Amityville Horror",       imageName: "amityville",       soundFile: "amityville"),
        Track(id: 6, title: "Unsolved Mysteries",      imageName: "question_mark",    soundFile: "unsolved_mysteries"),
        Track(id: 7, title: "X-Files",                 imageName: "magnifying_glass", soundFile: "xfiles"),
    ]

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
        guard let i = tracks.firstIndex(where: { $0.id == id }) else { return }
        let player = players[id]
        if tracks[i].isPlaying {
            player?.pause()
            tracks[i].isPlaying = false
        } else {
            player?.play()
            tracks[i].isPlaying = true
        }
    }

    func pauseAll() {
        for i in tracks.indices where tracks[i].isPlaying {
            players[tracks[i].id]?.pause()
            tracks[i].isPlaying = false
        }
    }
}

// MARK: - View

struct HorrorMovieView: View {
    @State private var model = HorrorMovieViewModel()

    var body: some View {
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
                            isPlaying: track.isPlaying
                        ) {
                            model.toggle(id: track.id)
                        }
                    }

                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .onDisappear {
            model.pauseAll()
        }
    }
}

#Preview {
    HorrorMovieView()
}
