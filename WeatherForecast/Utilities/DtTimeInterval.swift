//
//  DtTimeInterval.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 26/03/2023.
//

/*

Noen REST bruker dt som er sekunder siden 1970:
dt =  1679793239 er det samme som: 2023-03-26 01:13:59

timezonebd.com:
https://timezonedb.com/references/get-time-zone
key = MZ2KXGZFCHV
https://api.timezonedb.com/v2.1/get-time-zone?key=IMZ2KXGZFCHV&format=json&by=zone&zone=Asia/Taipei&time=1679764439

{
  "status": "OK",
  "message": "",
  "countryCode": "TW",
  "countryName": "Taiwan",
  "regionName": "",
  "cityName": "",
  "zoneName": "Asia/Taipei",
  "abbreviation": "CST",
  "gmtOffset": 28800,
  "dst": "0",
  "zoneStart": 307551600,
  "zoneEnd": null,
  "nextAbbreviation": null,
  "timestamp": 1679793239,
  "formatted": "2023-03-26 01:13:59"
}

*/

import Foundation

///  https://nsdateformatter.com

//  Thursday, Mar 25, 2021              EEEE, MMM d, yyyy
//  03/25/2021                          MM/dd/yyyy
//  03-25-2021 20:52                    MM-dd-yyyy HH:mm
//  Mar 25, 8:52                        PM MMM d, h:mm a
//  March 2021                          MMMM yyyy
//  Mar 25, 2021                        MMM d, yyyy
//  Thu, 25 Mar 2021 20:52:00 +0000     E, d MMM yyyy HH:mm:ss Z
//  2021-03-25T20:52:00+0000            yyyy-MM-dd'T'HH:mm:ssZ
//  25.03.21                            dd.MM.yy
//  20:52:00.455                        HH:mm:ss.SSS

func IntervalToHourMin(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.dateFormat = "HH:mm"
   return formatter.string(from: time as Date)
}

func IntervalToHour(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.dateFormat = "HH"
   return formatter.string(from: time as Date)
}

func IntervalToDayOfWeek(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd MMMM"
   return formatter.string(from: time as Date)
}

func IntervalToDayOfWeekHourMin(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd MMMM HH:mm"
   return formatter.string(from: time as Date)
}

func IntervalToWeekDay(interval: Int) -> String {
    let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "no")
    formatter.dateFormat = "E"
    let str = formatter.string(from: time as Date)
    return str.replacingOccurrences(of: ".", with: "")
}

func IntervalToDayOfMonth(interval: Int) -> String {
    let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "no")
    formatter.dateFormat = "dd"
    return formatter.string(from: time as Date)
 }

func IntervalToDate(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "E dd"
   return formatter.string(from: time as Date)
}

func IntervalToCompleteDayNameOfWeek(interval: Int) -> String {
   let time = NSDate(timeIntervalSince1970: TimeInterval(interval))
   let formatter = DateFormatter()
   formatter.locale = Locale(identifier: "no")
   formatter.dateFormat = "EEEE d. MMM"
   return formatter.string(from: time as Date)
}
