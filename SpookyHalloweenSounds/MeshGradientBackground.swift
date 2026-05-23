//
//  MeshGradientBackground.swift
//  SpookyHalloweenSounds
//

import SwiftUI

struct MeshGradientBackground: View {
    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 3,
                height: 3,
                points: Theme.meshPoints,
                colors: Theme.meshColors
            )
            .ignoresSafeArea()
        } else {
            // iOS 17 fallback: layered gradients
            ZStack {
                LinearGradient(
                    colors: [Theme.nearBlack, Theme.deepPurple, Theme.nearBlack],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                RadialGradient(
                    colors: [Theme.midPurple.opacity(0.7), .clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 350
                )
                .blendMode(.screen)

                RadialGradient(
                    colors: [Theme.burntOrange.opacity(0.45), .clear],
                    center: .bottomTrailing,
                    startRadius: 0,
                    endRadius: 400
                )
                .blendMode(.screen)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MeshGradientBackground()
}
