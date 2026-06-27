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

// MARK: - Orange ↔ purple pulse

// Slow sin oscillation between the theme orange and purple. Speed factor 0.4
// gives a full bright→deep→bright cycle every ~16 seconds.
func pulsingThemeColor(t: Double, speed: Double = 0.4) -> Color {
    let phase = (sin(t * speed) + 1) / 2
    return Color(
        red:   243.0/255 * (1 - phase) + 160.0/255 * phase,
        green: 127.0/255 * (1 - phase) +  35.0/255 * phase,
        blue:   54.0/255 * (1 - phase) + 220.0/255 * phase
    )
}

// Theme orange in dark mode, theme purple in light mode.
func adaptivePlayerColor(_ scheme: ColorScheme) -> Color {
    scheme == .dark
        ? Color(red: 243/255, green: 127/255, blue:  54/255)
        : Color(red: 160/255, green:  35/255, blue: 220/255)
}


// MARK: - Animated palette text

struct PaletteText: View {
    let text: String
    let font: Font
    var glowColor: Color = Color(red: 160/255, green: 35/255, blue: 220/255)
    var multiline: Bool = false

    private let orangeBright = Color(red: 255/255, green: 165/255, blue:  70/255)
    private let orangeDeep   = Color(red: 230/255, green: 100/255, blue:  20/255)

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 12.0)) { context in
            let rawT = context.date.timeIntervalSinceReferenceDate
            let glowRadius = 3.0 + 5.0 * (0.5 + 0.5 * sin(rawT * 0.6))
            let gradient = AngularGradient(
                colors: [orangeBright, orangeDeep, orangeBright, orangeDeep, orangeBright],
                center: .center,
                angle: .degrees(rawT * 12)
            )
            ZStack {
                Text(text).font(font).foregroundStyle(.black).offset(x: -1, y:  0)
                Text(text).font(font).foregroundStyle(.black).offset(x:  1, y:  0)
                Text(text).font(font).foregroundStyle(.black).offset(x:  0, y: -1)
                Text(text).font(font).foregroundStyle(.black).offset(x:  0, y:  1)
                Text(text)
                    .font(font)
                    .foregroundStyle(gradient)
            }
            .multilineTextAlignment(.center)
            .lineLimit(multiline ? nil : 1)
            .minimumScaleFactor(multiline ? 1.0 : 0.5)
            .shadow(color: glowColor.opacity(0.85), radius: glowRadius, x: 0, y: 0)
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
