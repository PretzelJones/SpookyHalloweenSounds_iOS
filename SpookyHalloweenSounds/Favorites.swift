//
//  Favorites.swift
//  SpookyHalloweenSounds
//

import Foundation
import Observation
import SwiftData

@Model
final class FavoriteSound {
    var soundFile: String
    var dateAdded: Date

    init(soundFile: String, dateAdded: Date = Date()) {
        self.soundFile = soundFile
        self.dateAdded = dateAdded
    }
}

@MainActor
@Observable
final class FavoritesStore {
    static let shared = FavoritesStore()

    private let container: ModelContainer
    private let context: ModelContext

    private(set) var favorites: [FavoriteSound] = []

    private init() {
        do {
            container = try ModelContainer(for: FavoriteSound.self)
            context = container.mainContext
        } catch {
            fatalError("FavoritesStore: failed to create ModelContainer: \(error)")
        }
        refresh()
    }

    var favoriteSoundFiles: [String] { favorites.map(\.soundFile) }

    func isFavorited(_ soundFile: String) -> Bool {
        favorites.contains { $0.soundFile == soundFile }
    }

    func toggle(_ soundFile: String) {
        if let existing = favorites.first(where: { $0.soundFile == soundFile }) {
            context.delete(existing)
        } else {
            context.insert(FavoriteSound(soundFile: soundFile))
        }
        try? context.save()
        refresh()
    }

    private func refresh() {
        let descriptor = FetchDescriptor<FavoriteSound>(sortBy: [SortDescriptor(\.dateAdded)])
        favorites = (try? context.fetch(descriptor)) ?? []
    }
}
