//
//  FindSunUpDown.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2022.
//

import Foundation

func FindSunUpDown(url: String,
                   offset: String,
                   days: Int,
                   latitude : Double?,
                   longitude: Double?,
                   offsetSec: Int) async -> (String, [String], [String], Int, Int) {
    
    var sunRise: [String] = Array(repeating: "", count: sizeArray10)
    var sunSet: [String] = Array(repeating: "", count: sizeArray10)
    var gesternRise: String = ""
    var gesternSet: String = ""
    var errors : String = ""
    var dayLength: Int = 0
    var dayIncrease: Int = 0
    var timeRise : String = ""
    var timeSet : String = ""
    var lat: String = ""
    var lon: String = ""
    
    if latitude != nil {
        lat = "\(latitude!)"
    } else {
        lat = "\(58.618050)" /// Varhaug
    }
    if longitude != nil {
        lon = "\(longitude!)"
    } else {
        lon = "\(5.655520)"  /// Varhaug
    }
    
    ///
    /// Den nye api fra met.no viser soloppgang og solnedgang for en dag:
    /// https://api.met.no/weatherapi/sunrise/3.0/sun?lat=58.617383&lon=5.64511&date=2023-06-29&offset=+02:00
    ///
    
    sunRise = []
    sunSet = []
    
    dayIncrease = 0
    dayLength = 0
    
    for i in -1...9 {
        let date = Date().adding(days: i)
        let calculatedDate = FormatDateToString(date: date, format: "yyyy-MM-dd", offsetSec: offsetSec)
        let urlString = url + "lat=" + lat + "&lon=" + lon + "&date=" + calculatedDate + "&offset=" + offset
        let url = URL(string: urlString)
        if let url {
            do {
                let urlSession = URLSession.shared
                let (jsonData, _) = try await urlSession.data(from: url)
                let metApi = try? JSONDecoder().decode(MetApiSun.self, from: jsonData)
                /// Sender kun HH:mm ;
                ///
                if metApi?.properties?.sunrise != nil {
                    let timeUp = (metApi?.properties!.sunrise.time)!
                    timeRise = ""
                    for j in 11...15 {
                        timeRise = timeRise + timeUp[j]
                    }
                }
                if metApi?.properties?.sunset != nil{
                    let timeDown = (metApi?.properties!.sunset.time)!
                    timeSet = ""
                    for j in 11...15 {
                        timeSet = timeSet + timeDown[j]
                    }
                }
            } catch {
                errors = "\(error)"
            }
        }
        if i == -1 {
            gesternRise = timeRise
            gesternSet = timeSet
       } else {
            sunRise.append(timeRise)
            sunSet.append(timeSet)
       }
    }
    dayLength = SunDailyLength(from: sunRise[0], to: sunSet[0])
    dayIncrease = dayLength - SunDailyLength(from: gesternRise, to: gesternSet)
    
    return (errors, sunRise, sunSet, dayLength, dayIncrease)
}
