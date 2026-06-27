//
//  GlassTile.swift
//  SpookyHalloweenSounds
//

import SwiftUI

struct GlassTile: View {
    let imageName: String
    let title: String
    let isPlaying: Bool
    let action: () -> Void
    var isFavorited: Bool? = nil
    var onToggleFavorite: (() -> Void)? = nil

    private let cornerRadius: CGFloat = 10
    private let favoritePurple = Color(red: 160/255, green: 35/255, blue: 220/255)

    @ViewBuilder
    private var iconImage: some View {
        if isPlaying {
            Image(systemName: "pause.fill")
                .font(.system(size: 20, weight: .bold))
        } else {
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
        }
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(spacing: 14) {
                iconImage
                    .foregroundStyle(.black)
                    .shadow(color: favoritePurple.opacity(0.9), radius: 6, x: 0, y: 0)
                    .frame(width: 28, height: 28)

                PaletteText(text: title, font: .custom("Creepster", size: 24))

                Spacer()

                if isFavorited != nil {
                    // Reserve space so the title doesn't slide under the heart.
                    Color.clear.frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isPlaying ? Theme.orange.opacity(0.5) : Theme.orange.opacity(0.18))
            )
            .contentShape(Rectangle())
            .onTapGesture { action() }

            if let isFavorited, let onToggleFavorite {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(isFavorited ? favoritePurple : .black)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
                    .onTapGesture { onToggleFavorite() }
                    .padding(.trailing, 16)
            }
        }
    }
}

#Preview {
    ZStack {
        MeshGradientBackground()
        VStack(spacing: 8) {
            GlassTile(imageName: "ultra_terror", title: "Ultra Terror", isPlaying: false) {}
            GlassTile(imageName: "spooky_sounds", title: "Spooky Sounds", isPlaying: true) {}
        }
        .padding()
    }
}
