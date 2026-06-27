//
//  MeshGradientBackground.swift
//  SpookyHalloweenSounds
//

import SwiftUI

struct MeshGradientBackground: View {

    // Resting — uniform grid
    private let pointsA: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5,  0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5,  0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5,  1.0], [1.0, 1.0],
    ]

    // Warped — orange rises to upper-right, purple drifts lower-left
    private let pointsB: [SIMD2<Float>] = [
        [0.0, 0.0], [0.65, 0.0], [1.0, 0.0],
        [0.0, 0.62], [0.38, 0.60], [1.0, 0.22],
        [0.0, 1.0], [0.40, 1.0], [1.0, 1.0],
    ]

    private func lerp(_ a: [SIMD2<Float>], _ b: [SIMD2<Float>], t: Float) -> [SIMD2<Float>] {
        zip(a, b).map { $0 + ($1 - $0) * t }
    }

    var body: some View {
        if #available(iOS 18.0, *) {
            // TimelineView drives animation from the clock — guaranteed to move
            TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
                let elapsed = context.date.timeIntervalSinceReferenceDate
                // sin oscillates -1…1 over an 18-second period; remap to 0…1
                let phase = Float((sin(elapsed * .pi / 9.0) + 1.0) * 0.5)
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: lerp(pointsA, pointsB, t: phase),
                    colors: Theme.meshColors
                )
            }
            .ignoresSafeArea()
        } else {
            // iOS 17 fallback: animate radial gradient centers
            AnimatedFallbackBackground()
        }
    }
}

private struct AnimatedFallbackBackground: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.nearBlack, Theme.deepPurple, Theme.nearBlack],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [Theme.midPurple.opacity(0.7), .clear],
                center: animate ? UnitPoint(x: 0.38, y: 0.60) : .center,
                startRadius: 0,
                endRadius: 350
            )
            .blendMode(.screen)
            RadialGradient(
                colors: [Theme.burntOrange.opacity(0.55), .clear],
                center: animate ? UnitPoint(x: 0.92, y: 0.22) : .bottomTrailing,
                startRadius: 0,
                endRadius: 420
            )
            .blendMode(.screen)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 9).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}

#Preview {
    MeshGradientBackground()
}
