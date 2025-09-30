//
//  CreateMoonCalendar.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/09/2025.
//

import SwiftUI

extension Date: @retroactive Identifiable {
    public var id: TimeInterval { timeIntervalSinceReferenceDate }
}

// MARK: - Moon Phase Calculation
struct MoonPhaseCalculator {
    static let synodicMonth = 29.53058867
    static let knownNewMoon = Date(timeIntervalSince1970: 592500000) // Jan 6, 1988
    
    static func moonPhase(for date: Date) -> Double {
        let daysSinceNewMoon = date.timeIntervalSince(knownNewMoon) / 86400
        let normalized = daysSinceNewMoon.truncatingRemainder(dividingBy: synodicMonth)
        return (normalized < 0 ? normalized + synodicMonth : normalized) / synodicMonth
    }
    
    static func moonPhaseSymbol(for phase: Double) -> String {
        switch phase {
        case 0.0..<0.125: return "🌑"
        case 0.125..<0.25: return "🌒"
        case 0.25..<0.375: return "🌓"
        case 0.375..<0.5: return "🌔"
        case 0.5..<0.625: return "🌕"
        case 0.625..<0.75: return "🌖"
        case 0.75..<0.875: return "🌗"
        default: return "🌘"
        }
    }
    
    static func moonPhaseName(for phase: Double) -> String {
        switch phase {
        case 0.0..<0.125: return "New Moon"
        case 0.125..<0.25: return "Waxing Crescent"
        case 0.25..<0.375: return "First Quarter"
        case 0.375..<0.5: return "Waxing Gibbous"
        case 0.5..<0.625: return "Full Moon"
        case 0.625..<0.75: return "Waning Gibbous"
        case 0.75..<0.875: return "Last Quarter"
        default: return "Waning Crescent"
        }
    }
    
    static func illumination(for phase: Double) -> Double {
        return 0.5 * (1 - cos(2 * .pi * phase))
    }
    
    static func nextMoon(of type: String, from date: Date) -> Date {
        var daysAhead = 1
        while daysAhead < 60 {
            if let candidate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: daysAhead, to: date) {
                let phase = moonPhase(for: candidate)
                if type == "New" && phase < 0.02 { return candidate }
                if type == "Full" && abs(phase - 0.5) < 0.02 { return candidate }
            }
            daysAhead += 1
        }
        return date
    }
}

// MARK: - Calendar View
struct MoonPhaseCalendar: View {
    @State private var currentMonth: Date = Date()
    @State private var selectedDate: Date? = nil
    private let calendar = Calendar.autoupdatingCurrent
    
    var body: some View {
        VStack {
            header
            weekdayLabels
            calendarGrid
        }
        .padding()
        .sheet(item: $selectedDate) { date in
            MoonDetailView(date: date)
        }
    }
    
    // MARK: - Header
    private var header: some View {
        HStack {
            Button(action: { changeMonth(by: -1) }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(monthTitle(for: currentMonth))
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Button(action: { changeMonth(by: 1) }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.bottom, 8)
    }
    
    // MARK: - Weekday Labels
    private var weekdayLabels: some View {
        let symbols = calendar.shortWeekdaySymbols
        let firstWeekday = calendar.firstWeekday - 1 // adjust for locale
        
        let orderedSymbols = Array(symbols[firstWeekday...] + symbols[..<firstWeekday])
        
        return HStack {
            ForEach(orderedSymbols, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Calendar Grid
    private var calendarGrid: some View {
        let days = daysInMonth(for: currentMonth)
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        
        return LazyVGrid(columns: columns, spacing: 0) {
            ForEach(days, id: \.self) { day in
                if let day = day {
                    let phase = MoonPhaseCalculator.moonPhase(for: day)
                    let symbol = MoonPhaseCalculator.moonPhaseSymbol(for: phase)
                    
                    VStack(spacing: 0) {
                        Text("\(calendar.component(.day, from: day))")
                            .font(.caption2)
                        Text(symbol)
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .onTapGesture {
                        selectedDate = day
                    }
                } else {
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    private func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMM", options: 0, locale: formatter.locale)
        return formatter.string(from: date)
    }
    
    private func daysInMonth(for date: Date) -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: date),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return []
        }
        
        var days: [Date?] = []
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let weekdayOffset = (firstWeekday - calendar.firstWeekday + 7) % 7
        
        // Empty slots before first day
        days.append(contentsOf: Array(repeating: nil, count: weekdayOffset))
        
        // Actual days
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        
        return days
    }
}

// MARK: - Detail Sheet
struct MoonDetailView: View {
    let date: Date
    private let calendar = Calendar.autoupdatingCurrent
    
    var body: some View {
        let phase = MoonPhaseCalculator.moonPhase(for: date)
        let symbol = MoonPhaseCalculator.moonPhaseSymbol(for: phase)
        let name = MoonPhaseCalculator.moonPhaseName(for: phase)
        let illumination = MoonPhaseCalculator.illumination(for: phase)
        let nextNew = MoonPhaseCalculator.nextMoon(of: "New", from: date)
        let nextFull = MoonPhaseCalculator.nextMoon(of: "Full", from: date)
        
        VStack(spacing: 20) {
            Text(formattedDate(date))
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(symbol)
                .font(.system(size: 80))
            
            Text(name)
                .font(.headline)
            
            Text("Illumination: \(Int(illumination * 100))%")
                .foregroundColor(.secondary)
            
            Divider()
            
            VStack(spacing: 8) {
                Text("Next New Moon: \(formattedDate(nextNew))")
                Text("Next Full Moon: \(formattedDate(nextFull))")
            }
            .font(.subheadline)
            
            Spacer()
        }
        .padding()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

