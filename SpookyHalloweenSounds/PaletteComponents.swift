//
//  PaletteComponents.swift
//  SpookyHalloweenSounds
//

import Combine
import SwiftUI

// MARK: - Palette color cycle

func themeColor(t: Double) -> Color {
    let stops: [(Double, Double, Double)] = [
        (243/255, 127/255,  54/255),
        (255/255, 100/255,  25/255),
        (160/255,  35/255, 220/255),
        (110/255,  20/255, 180/255),
        (255/255, 155/255,  65/255),
    ]
    let count = Double(stops.count)
    let wrapped = t.truncatingRemainder(dividingBy: count)
    let pos = wrapped < 0 ? wrapped + count : wrapped
    let i = Int(pos)
    let frac = pos - Double(i)
    let a = stops[i % stops.count]
    let b = stops[(i + 1) % stops.count]
    return Color(red: a.0 + (b.0 - a.0) * frac,
                 green: a.1 + (b.1 - a.1) * frac,
                 blue: a.2 + (b.2 - a.2) * frac)
}

// MARK: - Animated palette text

struct PaletteText: View {
    let text: String
    let font: Font
    var speed: Double = 0.13
    var glowColor: Color = Color(red: 160/255, green: 35/255, blue: 220/255)
    var outline: Bool = false

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 12.0)) { context in
            let rawT = context.date.timeIntervalSinceReferenceDate
            let t = rawT * speed
            let glowRadius = 3.0 + 5.0 * (0.5 + 0.5 * sin(rawT * 0.6))
            let gradient = LinearGradient(
                colors: [
                    themeColor(t: t),
                    themeColor(t: t + 1.67),
                    themeColor(t: t + 3.33),
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            if outline {
                ZStack {
                    Text(text).font(font).foregroundStyle(.black).offset(x: -2, y:  0)
                    Text(text).font(font).foregroundStyle(.black).offset(x:  2, y:  0)
                    Text(text).font(font).foregroundStyle(.black).offset(x:  0, y: -2)
                    Text(text).font(font).foregroundStyle(.black).offset(x:  0, y:  2)
                    Text(text).font(font).foregroundStyle(.black).offset(x: -1.5, y: -1.5)
                    Text(text).font(font).foregroundStyle(.black).offset(x:  1.5, y: -1.5)
                    Text(text).font(font).foregroundStyle(.black).offset(x: -1.5, y:  1.5)
                    Text(text).font(font).foregroundStyle(.black).offset(x:  1.5, y:  1.5)
                    Text(text)
                        .font(font)
                        .foregroundStyle(gradient)
                }
                .shadow(color: glowColor.opacity(0.85), radius: glowRadius, x: 0, y: 0)
            } else {
                Text(text)
                    .font(font)
                    .foregroundStyle(gradient)
                    .shadow(color: glowColor.opacity(0.85), radius: glowRadius, x: 0, y: 0)
            }
        }
    }
}

// MARK: - Animated palette icon

struct PaletteIconView: View {
    let imageName: String
    var speed: Double = 0.13

    @State private var rawT: Double = Date.now.timeIntervalSinceReferenceDate
    private let ticker = Timer.publish(every: 1.0 / 12.0, on: .main, in: .common).autoconnect()
    private let purple = Color(red: 160/255, green: 35/255, blue: 220/255)

    var body: some View {
        let glowRadius = 3.0 + 5.0 * (0.5 + 0.5 * sin(rawT * 0.6))
        let gradient = LinearGradient(
            colors: [
                themeColor(t: rawT * speed),
                themeColor(t: rawT * speed + 1.67),
                themeColor(t: rawT * speed + 3.33),
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        // Gradient is the explicit content; the image alpha shapes it via .mask.
        // Avoids template tinting and blend-mode quirks when this view ends up
        // inside a UIBarButtonItem (toolbar items bridge through UIKit).
        Rectangle()
            .fill(gradient)
            .mask {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
            .shadow(color: purple.opacity(0.85), radius: glowRadius, x: 0, y: 0)
            .onReceive(ticker) { date in
                rawT = date.timeIntervalSinceReferenceDate
            }
    }
}
