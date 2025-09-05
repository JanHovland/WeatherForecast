//
//  FindSunUpDown.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2022.
//

import Foundation
import SwiftUI

func FindSunUpDown(url: String,
                   offset: String,
                   days: Int,
                   latitude : Double?,
                   longitude: Double?,
                   offsetSec: Int) async -> (LocalizedStringKey, [String], [String], Int, Int) {
    
    var sunRise: [String] = Array(repeating: "", count: sizeArray10)
    var sunSet: [String] = Array(repeating: "", count: sizeArray10)
    var gesternRise: String = ""
    var gesternSet: String = ""
    var dayLength: Int = 0
    var dayIncrease: Int = 0
    var timeRise : String = ""
    var timeSet : String = ""
    var lat: String = ""
    var lon: String = ""
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    
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
                let (jsonData, response) = try await urlSession.data(from: url)
                ///
                /// Finner statusCode fra response
                ///
                let res = response as? HTTPURLResponse
                httpStatus = res!.statusCode

                if httpStatus == 200 {
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
                } else {
                    ///
                    /// Returnerer errorMessage
                    ///
                    errorMessage = ServerResponse(error:"\(response)")
                }
            } catch {
                ///
                /// Returnerer errorMessage
                ///
                let response = CatchResponse(response: "\(error)",
                                             searchFrom: "Code=",
                                             searchTo: "UserInfo")
                errorMessage = "\(response)"
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
    
    return (errorMessage, sunRise, sunSet, dayLength, dayIncrease)
}
