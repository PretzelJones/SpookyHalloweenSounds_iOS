//
//  MiniPlayerView.swift
//  SpookyHalloweenSounds
//

import SwiftUI
import AVFoundation

// MARK: - Helpers

private func formatTime(_ seconds: Double) -> String {
    guard seconds.isFinite, seconds >= 0 else { return "0:00" }
    let t = Int(seconds)
    return String(format: "%d:%02d", t / 60, t % 60)
}

// MARK: - Particle Orb

private struct LivingOrbView: View {
    let isPlaying: Bool
    var displaySize: CGFloat = 340

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 60.0)) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            Canvas { ctx, size in
                draw(ctx: ctx, size: size, t: t)
            }
        }
        .frame(width: 340, height: 340)
        .scaleEffect(displaySize / 340)
        .frame(width: displaySize, height: displaySize)
    }

    private func draw(ctx: GraphicsContext, size: CGSize, t: Double) {
        let cx = size.width / 2
        let cy = size.height / 2
        let energy = isPlaying ? 1.0 : 0.28

        // 7-second breath cycle — whole field expands and contracts
        let breath = 0.85 + 0.15 * sin(t * 2.0 * .pi / 7.0)
        let scale = energy * breath

        // --- Background blobs: 4 large soft glowing areas that drift independently ---
        for i in 0..<4 {
            let fi = Double(i)
            let seed = fi * 13.71
            let bx = cx + sin(t * 0.09 + seed) * 65.0 * scale
            let by = cy + cos(t * 0.07 + seed * 0.8) * 60.0 * scale
            let bSize = (38.0 + sin(t * 0.14 + seed) * 12.0) * scale
            let col = themeColor(t: t * 0.04 + seed * 1.2)
            for ring in 0..<5 {
                let rr = bSize * (1.0 + Double(ring) * 0.55)
                let alpha = max(0.0, (0.20 - Double(ring) * 0.034)) * scale
                ctx.fill(
                    Path(ellipseIn: CGRect(x: bx - rr, y: by - rr, width: rr * 2, height: rr * 2)),
                    with: .color(col.opacity(alpha))
                )
            }
        }

        // --- Core glow ---
        let coreR = (isPlaying ? 20.0 : 11.0) + sin(t * 2.3) * 3.0
        let coreCol = themeColor(t: t * 0.05)
        for ring in 0..<7 {
            let rr = coreR * (1.0 + Double(ring) * 0.6)
            let alpha = max(0.0, 0.38 - Double(ring) * 0.048)
            ctx.fill(
                Path(ellipseIn: CGRect(x: cx - rr, y: cy - rr, width: rr * 2, height: rr * 2)),
                with: .color(coreCol.opacity(alpha))
            )
        }

        // --- 120 particles on independent Lissajous paths ---
        // Each particle has its own x/y frequency pair so no circular structure emerges
        for i in 0..<120 {
            let fi = Double(i)
            let seed = fi * 6.317

            let ax = (18.0 + abs(sin(seed * 1.3)) * 68.0) * scale
            let ay = (18.0 + abs(cos(seed * 0.7)) * 68.0) * scale
            let wx = 0.22 + abs(sin(seed * 2.1)) * 0.38
            let wy = 0.25 + abs(cos(seed * 1.7)) * 0.44
            let px = seed * 0.11
            let py = seed * 0.13

            let x = cx + ax * sin(wx * t + px) + ay * 0.28 * cos(wy * 1.31 * t + px * 0.72)
            let y = cy + ay * cos(wy * t + py) + ax * 0.28 * sin(wx * 0.89 * t + py * 1.13)

            // Depth cue: closer to center = larger + brighter
            let dist = sqrt((x - cx) * (x - cx) + (y - cy) * (y - cy))
            let depth = 1.0 - min(1.0, dist / 140.0) * 0.5

            let pSize = max(0.5, (1.2 + sin(t * 1.9 + seed) * 0.6) * depth * (energy * 0.6 + 0.4))
            let alpha = (0.55 + sin(t * 0.85 + seed * 0.3) * 0.25) * depth * (energy * 0.7 + 0.3)

            // Each particle drifts through the palette at its own speed and offset
            let col = themeColor(t: t * (0.06 + sin(seed) * 0.02) + seed * 0.25)

            ctx.fill(
                Path(ellipseIn: CGRect(x: x - pSize / 2, y: y - pSize / 2,
                                       width: pSize, height: pSize)),
                with: .color(col.opacity(alpha))
            )
        }

        // --- Sparkles: bright white streaks that arc outward and fade ---
        let sparkCount = isPlaying ? 35 : 8
        for i in 0..<sparkCount {
            let fi = Double(i)
            let seed = fi * 11.973
            let phase = (t * energy * (0.08 + sin(seed) * 0.035) + seed * 0.1)
                .truncatingRemainder(dividingBy: 1.0)
            let life = phase < 0 ? phase + 1.0 : phase
            let r = 8.0 + life * 88.0 * energy
            let x = cx + r * cos(seed)
            let y = cy + r * sin(seed)
            let sparkAlpha = (1.0 - life) * (isPlaying ? 0.85 : 0.3)
            let sSize = max(0.5, (1.6 + (1.0 - life) * 1.4) * energy)
            ctx.fill(
                Path(ellipseIn: CGRect(x: x - sSize / 2, y: y - sSize / 2,
                                       width: sSize, height: sSize)),
                with: .color(Color.white.opacity(sparkAlpha))
            )
        }
    }
}

// MARK: - Container

// Wraps any view so the expanded player overlays live screen content.
// Each screen that hosts a mini player should wrap its body in this.
struct NowPlayingContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        let coordinator = NowPlayingCoordinator.shared
        content
            .overlay {
                if coordinator.showExpanded {
                    ExpandedPlayerView()
                        .ignoresSafeArea()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.42, dampingFraction: 0.76),
                        value: coordinator.showExpanded)
            .onDisappear {
                coordinator.showExpanded = false
            }
    }
}

// MARK: - Mini Bar

struct MiniPlayerBarView: View {
    @State private var progress: Double = 0
    @State private var isDragging = false
    @Environment(\.colorScheme) private var colorScheme

    private let ticker = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()

    var body: some View {
        let coordinator = NowPlayingCoordinator.shared
        VStack(spacing: 0) {
            if coordinator.isVisible {
                card(coordinator)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal:   .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
        }
        .animation(.spring(response: 0.42, dampingFraction: 0.76), value: coordinator.isVisible)
    }

    @ViewBuilder
    private func card(_ coordinator: NowPlayingCoordinator) -> some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.white.opacity(0.28))
                .frame(width: 36, height: 4)
                .padding(.top, 10)
                .padding(.bottom, 6)

            HStack(spacing: 10) {
                LivingOrbView(isPlaying: coordinator.isPlaying, displaySize: 64)

                PaletteText(text: coordinator.item?.title ?? "", font: .custom("Creepster", size: 24))
                    .lineLimit(1)

                Spacer()

                Button { coordinator.stop() } label: {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(width: 38, height: 38)
                        .contentShape(Rectangle())
                }

                Button { coordinator.togglePlayPause() } label: {
                    Image(systemName: coordinator.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(adaptivePlayerColor(colorScheme))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 2)

            Slider(value: $progress, in: 0...1) { editing in
                isDragging = editing
                if !editing { coordinator.seek(to: progress) }
            }
            .tint(adaptivePlayerColor(colorScheme))
            .padding(.horizontal, 14)
            .padding(.bottom, 10)
        }
        .background(.black.opacity(0.85), in: RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 160/255, green: 35/255, blue: 220/255).opacity(0.6), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.38), radius: 16, y: -5)
        .padding(.horizontal, 10)
        .padding(.bottom, 8)
        .contentShape(Rectangle())
        .onTapGesture { coordinator.showExpanded = true }
        .gesture(
            DragGesture(minimumDistance: 12)
                .onEnded { value in
                    if value.translation.height < -20 { coordinator.showExpanded = true }
                }
        )
        .onAppear { syncProgress(coordinator) }
        .onReceive(ticker) { _ in
            if !isDragging { syncProgress(coordinator) }
        }
    }

    private func syncProgress(_ coordinator: NowPlayingCoordinator) {
        guard let player = coordinator.item?.player, player.duration > 0 else { return }
        progress = player.currentTime / player.duration
    }
}

// MARK: - Expanded Player

struct ExpandedPlayerView: View {
    @State private var progress: Double = 0
    @State private var isDragging = false
    @State private var glowPulse = false
    @Environment(\.colorScheme) private var colorScheme

    private let ticker = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()

    var body: some View {
        let coordinator = NowPlayingCoordinator.shared

        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { coordinator.showExpanded = false }

            VStack(spacing: 0) {
                Capsule()
                    .fill(.white.opacity(0.30))
                    .frame(width: 40, height: 4)
                    .padding(.top, 14)
                    .padding(.bottom, 6)

                Spacer(minLength: 8)

                LivingOrbView(isPlaying: coordinator.isPlaying)
                    .padding(.bottom, 18)

                PaletteText(text: coordinator.item?.title ?? "", font: .custom("Creepster", size: 36))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Spacer(minLength: 10)

                VStack(spacing: 4) {
                    Slider(value: $progress, in: 0...1) { editing in
                        isDragging = editing
                        if !editing { coordinator.seek(to: progress) }
                    }
                    .tint(adaptivePlayerColor(colorScheme))

                    HStack {
                        Text(currentTimeLabel(coordinator))
                        Spacer()
                        Text(durationLabel(coordinator))
                    }
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.black)
                }
                .padding(.horizontal, 24)

                Spacer(minLength: 14)

                HStack(spacing: 52) {
                    Button {
                        coordinator.stop()
                    } label: {
                        Image(systemName: "stop.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white.opacity(0.75))
                            .frame(width: 52, height: 52)
                            .background(.white.opacity(0.1), in: Circle())
                            .overlay { Circle().stroke(.white.opacity(0.18), lineWidth: 1) }
                    }

                    Button { coordinator.togglePlayPause() } label: {
                        let color = adaptivePlayerColor(colorScheme)
                        Image(systemName: coordinator.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.black)
                            .frame(width: 72, height: 72)
                            .background(
                                Circle()
                                    .fill(color)
                                    .shadow(color: color.opacity(glowPulse ? 0.75 : 0.35),
                                            radius: glowPulse ? 18 : 8)
                            )
                    }
                }

                Spacer(minLength: 30)
            }
            .background(.black.opacity(0.85), in: RoundedRectangle(cornerRadius: 32))
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(red: 160/255, green: 35/255, blue: 220/255).opacity(0.6), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.45), radius: 20, y: 8)
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    if value.translation.height > 80 {
                        coordinator.showExpanded = false
                    }
                }
        )
        .task(id: coordinator.isPlaying) {
            if coordinator.isPlaying {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    glowPulse = true
                }
            } else {
                withAnimation(.easeInOut(duration: 0.55)) {
                    glowPulse = false
                }
            }
        }
        .onAppear { syncProgress(coordinator) }
        .onReceive(ticker) { _ in if !isDragging { syncProgress(coordinator) } }
    }

    private func syncProgress(_ coordinator: NowPlayingCoordinator) {
        guard let player = coordinator.item?.player, player.duration > 0 else { return }
        progress = player.currentTime / player.duration
    }

    private func currentTimeLabel(_ coordinator: NowPlayingCoordinator) -> String {
        guard let player = coordinator.item?.player else { return "0:00" }
        return formatTime(player.currentTime)
    }

    private func durationLabel(_ coordinator: NowPlayingCoordinator) -> String {
        guard let player = coordinator.item?.player, player.duration.isFinite else { return "0:00" }
        return formatTime(player.duration)
    }
}
