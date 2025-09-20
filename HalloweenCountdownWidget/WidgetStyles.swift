//
//  WidgetStyles.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 9/19/25.
//

import SwiftUI

// MARK: - Gradient Background (usable in .containerBackground)
struct HalloweenGradientBackground: ShapeStyle {
    func _apply(to shape: inout _ShapeStyle_Shape) {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 243/255, green: 127/255, blue: 54/255), // bright orange
                Color(red: 200/255, green: 80/255, blue: 20/255)   // deeper orange
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )._apply(to: &shape)
    }
}

// MARK: - Text & Overlay Effects
extension View {
    /// Add a Halloween-style orange glow/shadow
    func halloweenTextGlow() -> some View {
        self.shadow(color: .orange.opacity(0.8), radius: 4, x: 2, y: 2)
    }
    
    /// Overlay a subtle texture (e.g., spiderweb or grunge image at low opacity)
    func halloweenTextureOverlay(_ imageName: String, opacity: Double = 0.15) -> some View {
        self.overlay(
            Image(imageName)
                .resizable()
                .scaledToFill()
                .opacity(opacity)
        )
    }
}
