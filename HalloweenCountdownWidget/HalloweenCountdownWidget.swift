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
    
    enum HalloweekStatus {
        case countdown // > 1 day away
        case eve // 1 day away (Day before Halloween)
        case halloween // 0 days away (Halloween Day)
    }
    
    let status: HalloweekStatus
    
    // Memberwise initializer (used by getTimeline)
    init(date: Date, daysRemaining: Int, status: HalloweekStatus) {
        self.date = date
        self.daysRemaining = daysRemaining
        self.status = status
    }
    
    // Simple initializer (used by placeholder and getSnapshot)
    init(date: Date, daysRemaining: Int) {
        self.date = date
        self.daysRemaining = daysRemaining
        
        if daysRemaining <= 0 {
            self.status = .halloween
        } else if daysRemaining == 1 {
            self.status = .eve
        } else {
            self.status = .countdown
        }
    }
}

// MARK: - Provider
struct HalloweenCountdownProvider: TimelineProvider {
    func placeholder(in context: Context) -> HalloweenCountdownEntry {
        // Use the simple init
        HalloweenCountdownEntry(date: Date(), daysRemaining: 2)
    }

    func getSnapshot(in context: Context, completion: @escaping (HalloweenCountdownEntry) -> Void) {
        // Use the simple init, it calculates status
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
        let initialDaysRemaining = CountdownManager().daysUntilNextDate()

        // Generate entries for the next 7 days
        for offset in 0..<7 {
            if let entryDate = calendar.date(byAdding: .day, value: offset, to: startOfToday) {
                let daysRemaining = initialDaysRemaining - offset
                
                let status: HalloweenCountdownEntry.HalloweekStatus
                if daysRemaining <= 0 {
                    status = .halloween
                } else if daysRemaining == 1 {
                    status = .eve
                } else {
                    status = .countdown
                }
                
                let entry = HalloweenCountdownEntry(
                    date: entryDate,
                    daysRemaining: max(daysRemaining, 0),
                    status: status
                )
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
    
    // Helper to determine the text on the right side of the medium widget
    var mediumRightText: String {
        switch entry.status {
        case .eve:
            return "NIGHT BEFORE HALLOWEEN"
        case .halloween:
            return "HAPPY HALLOWEEN!"
        case .countdown:
            return "DAYS TILL HALLOWEEN"
        }
    }
    
    // Helper for the LEFT side of the MEDIUM widget (image/number logic)
    @ViewBuilder
    var mediumLeftContent: some View {
        switch entry.status {
        case .eve:
            // Medium: Night Before Halloween Image
            Image("moon_bats")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        case .halloween:
            // Medium: Halloween Day Image
            Image("jackolantern")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        case .countdown:
            // Medium: Regular Countdown Number
            ZStack {
                // ORANGE OUTLINE (for medium size)
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
                
                // BLACK FILL (for medium size)
                Text("\(entry.daysRemaining)")
                    .font(.custom("Creepster", size: 80))
                    .foregroundColor(.black)
            }
        }
    }
    
    // Original Content for the SMALL widget (ALWAYS the number)
    @ViewBuilder
    var smallContent: some View {
        ZStack {
            // ORANGE OUTLINE (for small size)
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
            .font(.custom("Creepster", size: 70))
            .foregroundColor(.orange)
            .opacity(0.95)
            
            // BLACK FILL (for small size)
            Text("\(entry.daysRemaining)")
                .font(.custom("Creepster", size: 90))
                .foregroundColor(.black)
        }
    }
    
    init(entry: HalloweenCountdownEntry) {
        self.entry = entry
    }
    
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                smallContent // The original, unchanging number logic
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerBackground(for: .widget) {
                // Background image fills the container shape
                Image("graveyard_square")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .background(Color.black)
            }
            .overlay {
                ContainerRelativeShape()
                    .strokeBorder(.black, lineWidth: 4)
            }

        case .systemMedium:
            HStack {
                mediumLeftContent // The new, changing image/number logic
                
                Spacer()
        
                ZStack {
                    Group {
                        // ORANGE OUTLINE for mediumRightText
                        Text(mediumRightText).offset(x: 1, y: 0)
                        Text(mediumRightText).offset(x: -1, y: 0)
                        Text(mediumRightText).offset(x: 0, y: 1)
                        Text(mediumRightText).offset(x: 0, y: -1)
                        Text(mediumRightText).offset(x: 1, y: 1)
                        Text(mediumRightText).offset(x: -1, y: 1)
                        Text(mediumRightText).offset(x: 1, y: -1)
                        Text(mediumRightText).offset(x: -1, y: -1)
                    }
                    .font(.custom("Creepster", size: 34))
                    .foregroundColor(.orange)
                    .opacity(0.95)

                    Text(mediumRightText) // Conditional Text
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
        // ONLY supporting Home Screen widgets
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

