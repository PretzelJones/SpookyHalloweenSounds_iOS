//
//  CountdownManager.swift
//  SpookyHalloweenSounds
//
//  Created by Sean Patterson on 10/13/24.
//


import Foundation

class CountdownManager {
    
    private let halloween: DateComponents = .init(calendar: .current, month: 11, day: 1)  // Set to November 1st

    func daysUntilNextDate() -> Int {
        let date = Date()
        guard let calendar = halloween.calendar,
              let nextDate = calendar.nextDate(after: date, matching: halloween, matchingPolicy: .strict) else {
            return .zero
        }
        let remainingDays = calendar.dateComponents([.day], from: date, to: nextDate).day ?? 0
        return max(remainingDays, 0)
    }
    
    func getCountdownText() -> String {
        let daysLeft = daysUntilNextDate()
        if daysLeft == 0 {
            return "Happy Halloween!"
        } else if daysLeft == 1 {
            return "Tomorrow is Halloween!"
        } else {
            return "\(daysLeft) days till Halloween"
        }
    }
}


