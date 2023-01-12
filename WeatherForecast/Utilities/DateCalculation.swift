//
//  DateCalculation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 25/10/2022.
//

import Foundation

///
/// Finn datoen for midnatt:
///
func MidNight(date: Date) -> Date {
    let calendar = Calendar.current
    let midNight = calendar.date(bySettingHour: 23,
                                    minute: 59,
                                    second: 59,
                                    of: date)
    return midNight!
}

/// Finner den riktige dateTime akkurat nå:
///
func GetLocalDate(date: Date) -> Date {
    let timezone = TimeZone.current
    let seconds = TimeInterval(timezone.secondsFromGMT(for: date))
    let dat = Date(timeInterval: seconds, since: date)
    return dat
}

/// Legger / trekker fra et antall timer fra dateTime akkurat nå:
///
func DateAddHour(hour : Int)->Date{
    let date = GetLocalDate(date: Date())
    return Calendar.current.date(byAdding: .hour, value: hour, to: date)!
}

/// Legger / trekker fra et antall dager fra dateTime akkurat nå:
///
func DateAddDay(day:Int)->Date{
    let date = GetLocalDate(date: Date())
    return Calendar.current.date(byAdding: .day, value: day, to: date)!
}

/// Legger / trekker fra et antall måneder fra dateTime akkurat nå:
///
func DateAddMonth(month:Int)->Date{
    let date = GetLocalDate(date: Date())
    return Calendar.current.date(byAdding: .month, value: month, to: date)!
}

/// Legger / trekker fra et antall år fra dateTime akkurat nå:
///
func DateAddYead(year:Int)->Date{
    let date = GetLocalDate(date: Date())
    return Calendar.current.date(byAdding: .year, value: year, to: date)!
}

/// Finner antall timer i forhold til UTC:
///
func HoursFromUTC() -> Int {
    var secondsFromUTC: Int
    secondsFromUTC = TimeZone.current.secondsFromGMT()
    return secondsFromUTC / 3600
}

/// Finner den lokal tidszonen:
///
func GetLocalTimeZoneAbbreviation() -> String {
///localTimeZoneAbbreviation   :  "GMT-2"
    ///
    var localTimeZoneAbbreviation: String
    localTimeZoneAbbreviation = String(TimeZone.current.abbreviation() ?? "")
    return localTimeZoneAbbreviation
}

/// Setter UTC tiden ut fra aktuell lokal tid i den lokale tidszonen:
///
func SetDateToUTC(hour: Int, day: Int, month: Int, year: Int) -> Date {
    var components = DateComponents()
    if let timeZone = TimeZone.current.abbreviation() {
        components.timeZone = TimeZone(abbreviation: timeZone)
        components.nanosecond = 0
        components.second = 0
        components.second = 0
        components.hour = hour
        components.day = day
        components.month = month
        components.year = year
        if let date = Calendar.current.date(from: components) {
            return date
        }
    }
    return Date()
}

/// Finner en ny dato "days" fremover i tid:
///
func ToDate(from : Date, days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: from)!
}

/// Finner området for datoer med "days" dager fremover:
///
func DateHourRange(date: Date) -> (Date, Date) {
    let day = Calendar.current.component(.day, from: date)
    let month = Calendar.current.component(.month, from: date)
    let year = Calendar.current.component(.year, from: date)
    let from = SetDateToUTC(hour: 0, day: day, month: month, year: year)
    let to  = ToDate(from: from, days: 1)
    return (from , to )
}

func OffsetFromUTC() -> String {
    
    var offset: String = ""
    
    let date = HoursFromUTC()
    
    if date >= 0 {
        offset = "+"
    } else {
        offset = "-"
    }
    
    offset = offset + String(format: "%02d", date)
    offset = offset + ":00"
    
    return offset
}
