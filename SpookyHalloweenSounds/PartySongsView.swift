//
//  PartySongsView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation
import Observation

// MARK: - View Model

@Observable
final class PartySongsViewModel {

    struct Track: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let soundFile: String
        var isPlaying: Bool = false
    }

    var tracks: [Track] = [
        Track(id: 0, title: "Ghostbusters",          imageName: "ghostbusters",    soundFile: "ghostbusters"),
        Track(id: 1, title: "I Put a Spell on You",  imageName: "hocus_pocus",     soundFile: "i_put_a_spell_on_you"),
        Track(id: 2, title: "Coraline",              imageName: "coraline",        soundFile: "coraline"),
        Track(id: 3, title: "This Is Halloween",     imageName: "jack_skellington", soundFile: "this_is_halloween"),
        Track(id: 4, title: "Little Shop of Horrors", imageName: "audrey",         soundFile: "little_shop_of_horrors"),
        Track(id: 5, title: "The Addams Family",     imageName: "creaky_door",     soundFile: "adams_family"),
        Track(id: 6, title: "Monster Mash",          imageName: "monster_mash",    soundFile: "monster_mash"),
        Track(id: 7, title: "Spooky Scary Skeletons", imageName: "spooky_skeletons", soundFile: "spooky_scary_skeletons"),
    ]

    private var players: [Int: AVAudioPlayer] = [:]

    init() {
        for track in tracks {
            let file = track.soundFile
            let url = Bundle.main.url(forResource: file, withExtension: "mp3")
                   ?? Bundle.main.url(forResource: file, withExtension: "wav")
            guard let url else {
                print("PartySongs: file not found — \(file)")
                continue
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = -1
                players[track.id] = player
            } catch {
                print("PartySongs: failed to load \(file): \(error)")
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

struct PartySongsView: View {
    @State private var model = PartySongsViewModel()

    var body: some View {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    Text("A frightfully fun mix of Halloween party favorites! Safe for kids, loved by grownups, and guaranteed to bring out your inner monster!")
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
    PartySongsView()
}
