//
//  AboutView.swift
//  SpookyHalloweenSounds
//

import SwiftUI

struct AboutView: View {
    let versionText: String

    var body: some View {
        ZStack {
            MeshGradientBackground() // handles .ignoresSafeArea() internally

            VStack(spacing: 0) {
                Image("tab_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 240)
                    .padding(.horizontal, 8)
                    .padding(.top, 20)

                Spacer()

                Text("Spooky Halloween Sounds is brought to you by")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Text("bosson design")
                    .font(.system(size: 52))
                    .foregroundColor(.white)
                    .padding(.top, 8)

                Spacer()

                Text(versionText)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    AboutView(versionText: "Version 1.3.3 (37)")
}
