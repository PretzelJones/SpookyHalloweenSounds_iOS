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
    }

    let tracks: [Track] = [
        Track(id: 0, title: "Ghostbusters",           imageName: "ghostbusters",     soundFile: "ghostbusters"),
        Track(id: 1, title: "I Put a Spell on You",   imageName: "hocus_pocus",      soundFile: "i_put_a_spell_on_you"),
        Track(id: 2, title: "Coraline",               imageName: "coraline",         soundFile: "coraline"),
        Track(id: 3, title: "This Is Halloween",      imageName: "jack_skellington",  soundFile: "this_is_halloween"),
        Track(id: 4, title: "Little Shop of Horrors", imageName: "audrey",           soundFile: "little_shop_of_horrors"),
        Track(id: 5, title: "The Addams Family",      imageName: "creaky_door",      soundFile: "adams_family"),
        Track(id: 6, title: "Monster Mash",           imageName: "monster_mash",     soundFile: "monster_mash"),
        Track(id: 7, title: "Spooky Scary Skeletons", imageName: "spooky_skeletons", soundFile: "spooky_scary_skeletons"),
    ]

    var playingId: Int? = nil

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

struct PartySongsView: View {
    @State private var model = PartySongsViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NowPlayingContainer {
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
    PartySongsView()
}
