//
//  HalloweenCountdownWidget.swift
//  HalloweenCountdownWidget
//
//  Created by Sean Patterson on 9/16/25.
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct HalloweenCountdownEntry: TimelineEntry {
    let date: Date
    let daysRemaining: Int
}

// MARK: - Provider
struct HalloweenCountdownProvider: TimelineProvider {
    func placeholder(in context: Context) -> HalloweenCountdownEntry {
        HalloweenCountdownEntry(date: Date(), daysRemaining: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (HalloweenCountdownEntry) -> Void) {
        let entry = HalloweenCountdownEntry(
            date: Date(),
            daysRemaining: CountdownManager().daysUntilNextDate()
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HalloweenCountdownEntry>) -> Void) {
        var entries: [HalloweenCountdownEntry] = []
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())

        // Generate entries for the next 7 days
        for offset in 0..<7 {
            if let entryDate = calendar.date(byAdding: .day, value: offset, to: startOfToday) {
                let daysRemaining = CountdownManager().daysUntilNextDate() - offset
                let entry = HalloweenCountdownEntry(date: entryDate, daysRemaining: max(daysRemaining, 0))
                entries.append(entry)
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


// MARK: - Widget View
struct HalloweenCountdownWidgetEntryView: View {
    var entry: HalloweenCountdownEntry
    @Environment(\.widgetFamily) var family
    
    init(entry: HalloweenCountdownEntry) {
        self.entry = entry
        
        // DEBUG: Print all fonts available in the widget target
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
        
    }
    
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                // ORANGE OUTLINE (8-direction offsets for a strong halo)
                Group {
                    Text("\(entry.daysRemaining)")
                        .offset(x: 1, y: 0)
                    Text("\(entry.daysRemaining)")
                        .offset(x: -1, y: 0)
                    Text("\(entry.daysRemaining)")
                        .offset(x: 0, y: 1)
                    Text("\(entry.daysRemaining)")
                        .offset(x: 0, y: -1)
                    Text("\(entry.daysRemaining)")
                        .offset(x: 1, y: 1)
                    Text("\(entry.daysRemaining)")
                        .offset(x: -1, y: 1)
                    Text("\(entry.daysRemaining)")
                        .offset(x: 1, y: -1)
                    Text("\(entry.daysRemaining)")
                        .offset(x: -1, y: -1)
                }
                .font(.custom("Creepster", size: 70))
                .foregroundColor(.orange)
                .opacity(0.95)

                // BLACK FILL (sharp foreground)
                Text("\(entry.daysRemaining)")
                    .font(.custom("Creepster", size: 90))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // ensure overlay hugs container edge
            .containerBackground(for: .widget) {
                // Background image fills the container shape
                Image("graveyard_square")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .background(Color.black)
            }
            // Draw a border that follows the widget's rounded shape (covers the white rim)
            .overlay {
                ContainerRelativeShape()
                    .strokeBorder(.black, lineWidth: 4)
            }

        case .systemMedium:
            HStack {
                ZStack {
                    Group {
                        Text("\(entry.daysRemaining)").offset(x: 1, y: 0)
                        Text("\(entry.daysRemaining)").offset(x: -1, y: 0)
                        Text("\(entry.daysRemaining)").offset(x: 0, y: 1)
                        Text("\(entry.daysRemaining)").offset(x: 0, y: -1)
                        Text("\(entry.daysRemaining)").offset(x: 1, y: 1)
                        Text("\(entry.daysRemaining)").offset(x: -1, y: 1)
                        Text("\(entry.daysRemaining)").offset(x: 1, y: -1)
                        Text("\(entry.daysRemaining)").offset(x: -1, y: -1)
                    }
                    .font(.custom("Creepster", size: 80))
                    .foregroundColor(.orange)
                    .opacity(0.95)
                    
                    Text("\(entry.daysRemaining)")
                        .font(.custom("Creepster", size: 80))
                        .foregroundColor(.black)
                }
                
                Spacer()
        
                ZStack {
                    Group {
                        Text("Days till Halloween").offset(x: 1, y: 0)
                        Text("Days till Halloween").offset(x: -1, y: 0)
                        Text("Days till Halloween").offset(x: 0, y: 1)
                        Text("Days till Halloween").offset(x: 0, y: -1)
                        Text("Days till Halloween").offset(x: 1, y: 1)
                        Text("Days till Halloween").offset(x: -1, y: 1)
                        Text("Days till Halloween").offset(x: 1, y: -1)
                        Text("Days till Halloween").offset(x: -1, y: -1)
                    }
                    .font(.custom("Creepster", size: 34))
                    .foregroundColor(.orange)
                    .opacity(0.95)

                    Text("Days till Halloween")
                        .font(.custom("Creepster", size: 34))
                        .foregroundColor(.black)
                }
            }
            .padding()
            .containerBackground(for: .widget) {
                Image("graveyard_rectangle")
                    .resizable()
                    .scaledToFill()
            }

        default:
            EmptyView()
        }
    }

}

// MARK: - Widget
@main
struct HalloweenCountdownWidget: Widget {
    let kind: String = "HalloweenCountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HalloweenCountdownProvider()) { entry in
            HalloweenCountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Halloween Countdown")
        .description("Shows the number of days remaining until Halloween.")
        //.supportedFamilies([.systemSmall, .systemMedium])
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular, .accessoryInline])
        .contentMarginsDisabled()
    }
}
