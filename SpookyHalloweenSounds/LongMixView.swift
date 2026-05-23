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
        var player: AVAudioPlayer?
    }

    var tracks: [Track] = [
        Track(id: 0, title: "Ultra Terror",      imageName: "ultra_terror",  soundFile: "ultra_terror"),
        Track(id: 1, title: "Haunted House",     imageName: "haunted_house", soundFile: "haunted_house"),
        Track(id: 2, title: "Spooky Sounds",     imageName: "spooky_sounds", soundFile: "long_mix"),
        Track(id: 3, title: "Space Terror",      imageName: "space_terror",  soundFile: "space_terror"),
        Track(id: 4, title: "Don't Let Them In", imageName: "key",           soundFile: "dont_let_in"),
    ]

    init() {
        for i in tracks.indices {
            let file = tracks[i].soundFile
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
                tracks[i].player = player
            } catch {
                print("LongMix: failed to load \(file): \(error)")
            }
        }
    }

    func toggle(id: Int) {
        guard let i = tracks.firstIndex(where: { $0.id == id }),
              let player = tracks[i].player else { return }
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
            tracks[i].player?.pause()
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

                    Image("graveyard")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.top, 4)
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
