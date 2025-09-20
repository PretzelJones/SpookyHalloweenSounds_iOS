//
//  HalloweenCountdownWidgetLiveActivity.swift
//  HalloweenCountdownWidget
//
//  Created by Sean Patterson on 9/16/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HalloweenCountdownWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HalloweenCountdownWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HalloweenCountdownWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension HalloweenCountdownWidgetAttributes {
    fileprivate static var preview: HalloweenCountdownWidgetAttributes {
        HalloweenCountdownWidgetAttributes(name: "World")
    }
}

extension HalloweenCountdownWidgetAttributes.ContentState {
    fileprivate static var smiley: HalloweenCountdownWidgetAttributes.ContentState {
        HalloweenCountdownWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HalloweenCountdownWidgetAttributes.ContentState {
         HalloweenCountdownWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HalloweenCountdownWidgetAttributes.preview) {
   HalloweenCountdownWidgetLiveActivity()
} contentStates: {
    HalloweenCountdownWidgetAttributes.ContentState.smiley
    HalloweenCountdownWidgetAttributes.ContentState.starEyes
}
