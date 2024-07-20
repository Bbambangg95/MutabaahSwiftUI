//
//  DateFormatter.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 13/08/23.
//

import SwiftUI

class DateUtils {
    static func getMonthName(date: Date, calendar: Calendar = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    static func getDateString(date: Date, calendar: Calendar = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    static func getDateOnlyString(date: Date, calendar: Calendar = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    static func calculateIntervalInDays(startDate: Date, endDate: Date, calendar: Calendar = .current) -> Int {
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        let days = components.day ?? 0
        return days
    }
    static func daysLeftMessage(endSprint: Date, now: Date = Date(), calendar: Calendar = .current) -> (String, Color) {
        if now > endSprint {
            let daysAgo = calendar.dateComponents([.day], from: endSprint, to: now).day ?? 0
            return ("\(daysAgo) day\(daysAgo == 1 ? "" : "s") ago", .red)
        } else {
            let daysLeft = calendar.dateComponents([.day], from: now, to: endSprint).day ?? 0
            return ("\(daysLeft) day\(daysLeft == 1 ? "" : "s") left", .orange)
        }
    }
    static func getDateFromMonth(month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 15
        if let date = Calendar.current.date(from: dateComponents) {
            return date
        } else {
            fatalError("Invalid date components")
        }
    }
}
