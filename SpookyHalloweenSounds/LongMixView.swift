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
        var isPlaying: Bool = false
    }

    var tracks: [Track] = [
        Track(id: 0, title: "Ultra Terror",      imageName: "ultra_terror",   soundFile: "ultra_terror"),
        Track(id: 1, title: "Haunted House",     imageName: "haunted_circus", soundFile: "haunted_house"),
        Track(id: 2, title: "Spooky Sounds",     imageName: "spooky_sounds",  soundFile: "long_mix"),
        Track(id: 3, title: "Space Terror",      imageName: "space_terrors",  soundFile: "space_terror"),
        Track(id: 4, title: "Don't Let Them In", imageName: "key",            soundFile: "dont_let_in"),
    ]

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
        guard let i = tracks.firstIndex(where: { $0.id == id }),
              let player = players[id] else { return }
        if player.isPlaying {
            player.pause()
            tracks[i].isPlaying = false
        } else {
            player.play()
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

struct LongMixView: View {
    @State private var model = LongMixViewModel()

    var body: some View {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    Text("The looping sounds will continue to play indefinitely! Press a button a second time to pause, or press two or more to mix sounds together.")
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
    LongMixView()
}
