CLAUDE.md
Drop this file in the root of the Spooky Halloween Sounds repo. Claude Code auto reads it every session. Keep it updated as priorities shift.
Project Overview
Spooky Halloween Sounds is a native mobile soundboard and ambient audio app for iOS and Android. Users tap tiles to play spooky sounds, layer multiple sounds together for ambient horror scenes, and use it for parties, sleep, focus, and writing inspiration. Target users are adults and families during the Halloween season, with year round use for ambient horror and sleep sounds.
Current Priority: Modernization Rework
The app needs a top to bottom modernization pass. The two pillars are a modern visual design and improved playback. Treat this as the primary objective for the next milestone. Other work waits until this lands.
Before starting any large change in this rework, restate the plan in your own words and wait for confirmation. Step by step, one feature at a time.
Visual Design Direction
Confirmed direction:

Mesh gradient backgrounds across primary screens. Moody Halloween palette, deep purple to burnt orange to near black. iOS uses SwiftUI MeshGradient (iOS 18 plus). Android uses a Compose Brush with a custom AGSL or Skia shader, or RadialGradient and LinearGradient layered with blend modes as a fallback.
Glass surfaces for tiles, sheets, and overlays. iOS 26 uses Liquid Glass materials. iOS 17 and 18 fall back to .ultraThinMaterial. Android uses translucent Material 3 surfaces with RenderEffect.createBlurEffect on API 31 plus, and a tinted scrim fallback below that.
Persistent mini player docked at the bottom of every screen when audio is playing. Shows current sound name, art, play and pause, and a thin progress or loop indicator.
Swipe up on the mini player expands to a full now playing view. Tap or swipe down collapses it. Behavior should mirror Apple Music and Spotify so users do not need to learn it.

Proposals that I am recommending but need your sign off before implementation:

Dark mode only, since the brand is spooky. Light mode adds maintenance cost for low payoff. Confirm or override.
Subtle ambient motion on the background mesh gradient. Slow drift, like fog. No reactive audio visualizer in v1 since that drains battery and complicates the design.
Spring animation on tile tap with light haptic on iOS (UIImpactFeedbackGenerator medium) and Android (HapticFeedbackConstants.CONTEXT_CLICK). Tactile but not toy like.
Custom typography. Pair a display face for headers with a neutral sans for body. Variable fonts preferred to keep binary size down. Specific face TBD.
App icon refresh. Tinted and dark variants for iOS 18 plus. Themed icon for Android 13 plus.

Pause and ask before touching anything outside the confirmed list.
Playback Improvements
Confirmed direction:

Background playback that survives lock screen and app backgrounding. iOS via AVAudioSession .playback category. Android via foreground service tied to MediaSession and Media3 ExoPlayer.
Lock screen and Control Center controls with current sound metadata and artwork on both platforms.
Gapless looping. Verify with 2 to 5 second test clips before declaring a longer clip works.
Bluetooth, AirPods, and wired headset routing without manual reconfiguration. Handle route changes mid playback gracefully.

Proposals that I am recommending but need your sign off before implementation:

Multi sound mixing. Tap multiple tiles to layer sounds. Per stream volume slider in the expanded player. Master soft limiter on the mix bus to prevent clipping. iOS uses AVAudioEngine with multiple AVAudioPlayerNode inputs. Android uses ExoPlayer per stream with an audio processor for limiting, or AudioTrack plus OboeAudioStream for lower latency.
Sleep timer with fade out. 5, 15, 30, 60 minute presets and a custom value.
Favorites and saved mixes. Persist with SwiftData on iOS and Room on Android. No cloud sync in v1.
AirPlay 2 on iOS and Google Cast on Android. Both are mostly free once MediaSession is correct.
CarPlay and Android Auto support. Defer to v1.1 unless you say otherwise. Audio apps need to declare an entitlement on Apple's side, and the review bar is real.
Haptics on tap as noted in the visual section. Toggleable in settings.
Categories or tags for filtering, like Ambient, Jump Scares, Music, Vocal, Weather. Decision needed on whether categories are a top level navigation pattern or a filter sheet.

Confirm silent switch behavior before coding it. A soundboard for active scares plays through silent. An ambient sleep app respects silent. This app does both, so the rule needs to come from you. Default proposal: play through silent always, since most use cases are deliberate.
Tech Stack
iOS:

Minimum deployment iOS 17. Target latest stable.
Swift 6 with strict concurrency. SwiftUI primary. UIKit only where SwiftUI cannot reach.
Audio: AVAudioPlayer for simple one shot, AVAudioEngine for mixing and effects.
Persistence: SwiftData.
State: @Observable from the Observation framework, not Combine.
Live Activities and home screen widgets via WidgetKit, deferred to v1.1 unless prioritized.

Android:

minSdk 26, targetSdk latest stable.
Kotlin with coroutines. Jetpack Compose primary. Views only where Compose cannot reach.
Audio: Media3 ExoPlayer plus MediaSession. No legacy MediaPlayer.
Persistence: Room.
State: Compose state plus ViewModel. No third party state libraries.
Material 3 Expressive where available. Predictive back gestures enabled.

Shared:

Audio assets: AAC .m4a or Opus .ogg at 44.1 kHz. WAV or FLAC masters kept in a separate assets repo.
No cross platform frameworks unless explicitly requested.
Git with conventional commits.

Audio Engineering Rules
These are non negotiable:

All loops gapless. Test with short clips first.
Multiple simultaneous sounds must not clip. Per stream gain plus master soft limiter.
Pause on audio focus loss and phone calls. Resume only when user expectation is clear.
Lock screen Now Playing metadata accurate at all times.
No audio glitches on route changes.

Asset Licensing
Audio licensing is the single biggest legal risk. Before using any sound:

Verify the license permits commercial use in an app store distributed app.
Track every asset in a license CSV with source, license type, license URL, and date acquired.
Prefer CC0 or paid royalty free libraries with app distribution rights.
Never use sounds from copyrighted movies, TV, or music.

Call this out anytime a new sound is added.
Code Style and Workflow

State the file and function or class being changed before showing code.
Show full files unless I ask for a diff. The trigger phrase is "full file."
Identify the problem, propose a fix, only write code when I explicitly ask.
Avoid showing code if no changes are needed.
Match existing formatting and structure across similar files.
Prefer the simplest solution that works. No premature abstractions.
One feature at a time. Wait for confirmation before moving to the next.

Response Style

Lead with the most important information in the first sentence.
Concise and short. No filler.
No bold text. No hyphens. Use commas, colons, periods, or restructure.
Surfer dude tone is welcome but cannot bury the technical answer.
Do not present assumptions or common practice as documented fact. Cite Apple or Google docs, or label as general knowledge or best practice.
Trigger phrase "potato" means drop the helpful persona and give the brutally honest assessment.
Trigger phrase "step by step" means do one thing then stop.

Build and Run Commands
iOS:
TBD, fill in after Xcode project layout is set
Android:
TBD, fill in after Gradle setup is set
Update this section as soon as the project structure is finalized.
Out of Scope Unless I Ask

Backend, server side, or cloud sync
Subscriptions or in app purchases until v1 ships
Third party analytics
Cross platform refactors (Flutter, React Native, KMP)
Marketing copy

Always Verify Before Recommending

Target iOS and Android versions, defaults above unless I update
Real device versus simulator, audio behavior differs
Media3 versus legacy MediaPlayer, Media3 is current per Google
Audio file format, sample rate, and bit depth consistency
Whether the request is a problem statement or a code request

How to Approach the Rework
Work in this order unless I say otherwise:

Read the existing repo. Summarize current structure, dependencies, and any technical debt. Wait for confirmation before changing anything.
Propose a phased rework plan. Phase 1 visual foundation (mesh gradient and glass surfaces), phase 2 mini player with expand gesture, phase 3 playback improvements (mixing, sleep timer, favorites), phase 4 polish (haptics, animations, icon).
After plan approval, tackle one phase at a time, one screen or feature at a time inside each phase.
Land each phase on both platforms before moving on, unless I say to push one platform first.
