import AVFoundation
import UIKit

class AudioPlayerManager: NSObject, AVAudioPlayerDelegate {
    private var audioPlayer: AVAudioPlayer?
    private var associatedButton: UIButton?
    private var defaultImageName: String?
    private var pauseImageName: String?

    // Function to load audio and pass button with images
    func loadAudio(fileName: String, fileType: String, button: UIButton, defaultImage: String, pauseImage: String) {
        self.associatedButton = button
        self.defaultImageName = defaultImage
        self.pauseImageName = pauseImage

        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
                let url = URL(fileURLWithPath: path)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.delegate = self
            }
        } catch {
            print("Error loading audio file: \(error)")
        }
    }

    // Function to play/pause the audio and trigger pulsate/haptic effects
    func playPauseAudio() {
        guard let player = audioPlayer, let button = associatedButton else { return }

        // Trigger haptic and pulsate effects for the button
        button.haptic(button)
        button.pulsate(button)

        if player.isPlaying {
            player.pause()
            button.setImage(UIImage(named: defaultImageName ?? ""), for: .normal) // Reset to default image
        } else {
            player.play()
            button.setImage(UIImage(named: pauseImageName ?? ""), for: .normal) // Set pause image
        }
    }

    // Reset button UI when audio finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let button = associatedButton {
            button.setImage(UIImage(named: defaultImageName ?? ""), for: .normal) // Reset to default image
            button.backgroundColor = .systemOrange // Example background color reset
        }
    }
}

