//
//  AboutView.swift
//  SpookyHalloweenSounds
//

import SwiftUI

struct FlyingBat: View {
    let angleDegrees: Double
    let duration: Double
    let delay: Double
    let flipped: Bool
    var travelRadius: Double = 340
    var batWidth: CGFloat = 36

    @State private var startDate: Date? = nil

    var body: some View {
        let radians = angleDegrees * .pi / 180
        TimelineView(.animation) { context in
            let t = startDate.map { start in
                (context.date.timeIntervalSince(start).truncatingRemainder(dividingBy: duration)) / duration
            } ?? 0.0
            let eased = t * t * t
            Image("bat_single")
                .resizable()
                .scaledToFit()
                .frame(width: batWidth)
                .scaleEffect(x: flipped ? -1 : 1, y: 1)
                .scaleEffect(0.06 + 6.94 * eased)
                .offset(
                    x: cos(radians) * travelRadius * eased,
                    y: sin(radians) * travelRadius * eased
                )
                .opacity(startDate == nil ? 0 : 1.0 - t)
        }
        .task {
            try? await Task.sleep(for: .seconds(delay))
            startDate = Date()
        }
    }
}

struct AboutView: View {
    let versionText: String

    private let bats: [(angle: Double, duration: Double, delay: Double, flipped: Bool)] = [
        (-120, 1.8, 0.0, false),
        (-90,  1.6, 0.5, true),
        (-60,  2.0, 1.0, false),
        (-150, 1.7, 0.3, true),
        (-30,  1.9, 0.8, false),
        (150,  2.1, 1.3, true),
        (30,   1.8, 0.6, false),
    ]

    var body: some View {
        ZStack {
            MeshGradientBackground()

            // Moon centered on screen
            Image("full_moon")
                .resizable()
                .scaledToFit()
                .frame(width: 360)
                .overlay {
                    ForEach(Array(bats.enumerated()), id: \.offset) { _, config in
                        FlyingBat(
                            angleDegrees: config.angle,
                            duration: config.duration,
                            delay: config.delay,
                            flipped: config.flipped
                        )
                    }
                }

            VStack(spacing: 0) {
                Image("tab_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    .padding(.horizontal, 8)
                    .padding(.top, 20)

                Spacer()

                PaletteText(text: "Spooky Halloween Sounds is brought to you by", font: .custom("Creepster", size: 22))
                    .padding(.horizontal, 40)

                PaletteText(text: "Sean Patterson", font: .custom("Creepster", size: 52))
                    .padding(.top, 8)

                Spacer()

                PaletteText(text: versionText, font: .custom("Creepster", size: 22))
                    .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AboutView(versionText: "Version 1.3.3 (37)")
}
