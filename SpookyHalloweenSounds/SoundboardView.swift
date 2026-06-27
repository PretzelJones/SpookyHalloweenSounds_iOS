//
//  SoundboardView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation
import Observation

// MARK: - Navigation destination

enum SoundboardDestination {
    case loopingMixes, horrorMovies, partySongs
}

// MARK: - Delegate bridge (NSObject required by AVAudioPlayerDelegate)

private final class AudioFinishDelegate: NSObject, AVAudioPlayerDelegate {
    var onFinish: (AVAudioPlayer) -> Void = { _ in }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { self.onFinish(player) }
    }
}

// MARK: - View Model

@Observable
final class SoundboardViewModel {

    struct Track: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let soundFile: String
        var isPlaying: Bool = false
    }

    struct NavTile: Identifiable {
        let id: Int
        let title: String
        let imageName: String
        let destination: SoundboardDestination
    }

    let navTiles: [NavTile] = [
        NavTile(id: 0, title: "Looping Mixes",            imageName: "loop",      destination: .loopingMixes),
        NavTile(id: 1, title: "Horror Movie & TV Themes",  imageName: "projector", destination: .horrorMovies),
        NavTile(id: 2, title: "Kids & Party Songs",        imageName: "note",      destination: .partySongs),
    ]

    var tracks: [Track] = [
        Track(id: 0,  title: "Witch Cackle",       imageName: "witch",            soundFile: "witch_laugh"),
        Track(id: 1,  title: "Black Cat",           imageName: "black_cat",        soundFile: "black_cat"),
        Track(id: 2,  title: "Creepy Laugh",        imageName: "evil_man",         soundFile: "evil_man"),
        Track(id: 3,  title: "Creaky Door",         imageName: "creaky_door",      soundFile: "creaky_door"),
        Track(id: 4,  title: "Horror Ambiance",     imageName: "spider",           soundFile: "horror_ambience"),
        Track(id: 5,  title: "Monster Growl",       imageName: "monster_growl",    soundFile: "monster_growl"),
        Track(id: 6,  title: "Monster Walking",     imageName: "monster_walking",  soundFile: "monster_walking"),
        Track(id: 7,  title: "Spooky Chains",       imageName: "chains",           soundFile: "spooky_chains"),
        Track(id: 8,  title: "Thunderstorm",        imageName: "thunder",          soundFile: "thunder"),
        Track(id: 9,  title: "Scary Scream",        imageName: "scream",           soundFile: "scary_scream"),
        Track(id: 10, title: "Zombie Groan",        imageName: "zombie",           soundFile: "zombie"),
        Track(id: 11, title: "Ghost Boo",           imageName: "ghost_boo",        soundFile: "ghost_boo"),
        Track(id: 12, title: "Werewolf Howl",       imageName: "werewolf",         soundFile: "werewolf_howl"),
        Track(id: 13, title: "Poltergeist Voice",   imageName: "poltergeist_tv",   soundFile: "poltergeist_voice"),
        Track(id: 14, title: "Zombie Call",         imageName: "zombie_call",      soundFile: "zombie_come"),
        Track(id: 15, title: "Cat Scream",          imageName: "cat_scream",       soundFile: "cat_scream"),
        Track(id: 16, title: "Wraith Wail",         imageName: "wraith_wail",      soundFile: "wraith_wail"),
        Track(id: 17, title: "Spooky Owl",          imageName: "spooky_owl",       soundFile: "spooky_owl"),
        Track(id: 18, title: "Chained Ghoul",       imageName: "chained_ghoul",    soundFile: "chained_ghoul"),
        Track(id: 19, title: "Terrified Scream",    imageName: "terrified_scream", soundFile: "terrified_scream"),
        Track(id: 20, title: "Haunted Organ",       imageName: "haunted_organ",    soundFile: "haunted_organ"),
        Track(id: 21, title: "Scarecrow",           imageName: "scarecrow",        soundFile: "scarecrow"),
        Track(id: 22, title: "Blowing Wind",        imageName: "blowing_wind",     soundFile: "blowing_wind"),
        Track(id: 23, title: "Ghostly Whisper",     imageName: "ghostly_whisper",  soundFile: "ghostly_whisper"),
        Track(id: 24, title: "Dracula Laugh",       imageName: "dracula_laugh",    soundFile: "dracula_laugh"),
        Track(id: 25, title: "Wolf Cry",            imageName: "wolf",             soundFile: "wolf_cry"),
        Track(id: 26, title: "Knock Knock",         imageName: "knock",            soundFile: "knock_knock"),
        Track(id: 27, title: "Igor Grumble",        imageName: "igor",             soundFile: "igor_grumble"),
        Track(id: 28, title: "Horror Movie",        imageName: "film",             soundFile: "horror_film"),
        Track(id: 29, title: "Warning Bells",       imageName: "warning_bells",    soundFile: "warning_bells"),
        Track(id: 30, title: "Painful Moan",        imageName: "grave_stone",      soundFile: "painful_moan"),
        Track(id: 31, title: "Witches Cauldron",    imageName: "witches_cauldron", soundFile: "bubbles"),
        Track(id: 32, title: "Ghostly Children",    imageName: "ghostly_children", soundFile: "scary_nursery"),
        Track(id: 33, title: "Haunted Swamp",       imageName: "haunted_swamp",    soundFile: "haunted_swamp"),
        Track(id: 34, title: "Tortured Souls",      imageName: "tortured_souls",   soundFile: "tortured_souls"),
        Track(id: 35, title: "Chilling Horn",       imageName: "alien",            soundFile: "chilling_horn"),
    ]

    private var players: [Int: AVAudioPlayer] = [:]
    private let audioDelegate = AudioFinishDelegate()

    @MainActor
    var sortedTracks: [Track] {
        let store = FavoritesStore.shared
        let order = store.favoriteSoundFiles
        let favoritedSet = Set(order)
        let favorited: [Track] = order.compactMap { sf in
            tracks.first { $0.soundFile == sf }
        }
        let rest = tracks.filter { !favoritedSet.contains($0.soundFile) }
        return favorited + rest
    }

    init() {
        audioDelegate.onFinish = { [weak self] player in
            self?.handleFinished(player)
        }
        for track in tracks {
            let file = track.soundFile
            let url = Bundle.main.url(forResource: file, withExtension: "mp3")
                   ?? Bundle.main.url(forResource: file, withExtension: "wav")
            guard let url else {
                print("Soundboard: file not found — \(file)")
                continue
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = audioDelegate
                players[track.id] = player
            } catch {
                print("Soundboard: failed to load \(file): \(error)")
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

    private func handleFinished(_ player: AVAudioPlayer) {
        if let id = players.first(where: { $0.value === player })?.key,
           let i = tracks.firstIndex(where: { $0.id == id }) {
            tracks[i].isPlaying = false
        }
    }
}

// MARK: - View

struct SoundboardView: View {
    let model: SoundboardViewModel
    var onNavigate: (SoundboardDestination) -> Void = { _ in }

    var body: some View {
        NowPlayingContainer {
        ZStack {
            MeshGradientBackground()

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(model.navTiles) { tile in
                        GlassTile(
                            imageName: tile.imageName,
                            title: tile.title,
                            isPlaying: false
                        ) {
                            onNavigate(tile.destination)
                        }
                    }

                    ForEach(model.sortedTracks) { track in
                        GlassTile(
                            imageName: track.imageName,
                            title: track.title,
                            isPlaying: track.isPlaying,
                            action: { model.toggle(id: track.id) },
                            isFavorited: FavoritesStore.shared.isFavorited(track.soundFile),
                            onToggleFavorite: {
                                withAnimation(.smooth(duration: 0.25)) {
                                    FavoritesStore.shared.toggle(track.soundFile)
                                }
                            }
                        )
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
    }
}

#Preview {
    SoundboardView(model: SoundboardViewModel())
}
