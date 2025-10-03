//
//  TimeUtilities.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/09/2025.
//

import Foundation

    // Formats a Unix timestamp (seconds since 1970) to local "HH:mm"
func formatTime(fromUnixSeconds seconds: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(seconds))
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = .autoupdatingCurrent
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

    // Calculates signed whole-day difference (positive if end is after start)
func signedDaysBetweenUnixTimestamps(_ startSeconds: Int, _ endSeconds: Int) -> Int {
    let calendar = Calendar.autoupdatingCurrent
    let startDate = Date(timeIntervalSince1970: TimeInterval(startSeconds))
    let endDate = Date(timeIntervalSince1970: TimeInterval(endSeconds))
    let startDay = calendar.startOfDay(for: startDate)
    let endDay = calendar.startOfDay(for: endDate)
    return calendar.dateComponents([.day], from: startDay, to: endDay).day ?? 0
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // format like "2024-09-22"
    return formatter.string(from: date)
}

func formatTimestamp(timestamp: TimeInterval, offsetSec: Int) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE d. MMMM yyyy HH:mm"
    formatter.locale = Locale(identifier: "nb_NO")
    formatter.timeZone = TimeZone(secondsFromGMT: offsetSec)  
    return formatter.string(from: date)
}

