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

    private let cornerRadius: CGFloat = 10

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Group {
                    if isPlaying {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 20, weight: .bold))
                    } else {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 28, height: 28)

                Text(title)
                    .font(.custom("Creepster", size: 24))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isPlaying ? Theme.orange.opacity(0.5) : Theme.orange.opacity(0.18))
            )
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
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
