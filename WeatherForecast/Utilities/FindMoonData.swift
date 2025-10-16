//
//  FindMoonData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/09/2025.
//

import Foundation

private func formatTimeIfPresent(_ seconds: Int?) -> String {
    guard let seconds else { return "" }
    return formatTime(fromUnixSeconds: seconds)
}

func findMoonData(date: String,
                  url: String,
                  latitude: Double,
                  longitude: Double,
                  apiKey: String,
                  apiHost: String,
                  statusCode: Bool,
                  prettyPrint: Bool,
                  offsetSec: Int) async -> MoonData {
    
    // Ensure the local variable is initialized on all paths
    let moonData = MoonData(phaseName: "",
                            majorPhase: "",
                            phase: 0.00,
                            stage: "",
                            moonSign: "",
                            sunSign: "",
                            emoji: "",
                            illumination: "",
                            daysUntilNextFullMoon: 0,
                            moonrise: "",
                            moonset: "",
                            distance: 0.00,
                            fullMoon: "",
                            newMoon: "")
    
    let urlString = url + "lat=" + "\(latitude)" + "&lon=" + "\(longitude)" + "&date=" + date
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        return moonData
    }
    
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if statusCode {
            if let http = response as? HTTPURLResponse {
                print("HTTP \(http.statusCode)")
                if let contentType = http.value(forHTTPHeaderField: "Content-Type") {
                    print("Content-Type:", contentType)
                }
            }
            
            if let rawString = String(data: data, encoding: .utf8) {
                print("Raw response string:")
                print(rawString)
            } else {
                print("Response is not valid UTF-8.")
            }
        }
        
        if prettyPrint {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Pretty JSON:")
                print(prettyString)
            } else {
                print("Response did not parse as JSON via JSONSerialization.")
            }
        }
        
        do {
            let decoded = try JSONDecoder().decode(RapidAdvanced.self, from: data)
  
            moonData.phaseName = decoded.moon.phaseName
            
            moonData.majorPhase = String(format: NSLocalizedString(decoded.moon.majorPhase, comment: ""))
            
            moonData.phase = decoded.moon.phase
            moonData.stage = decoded.moon.stage
            
            moonData.moonSign = String(format: NSLocalizedString(decoded.moon.zodiac.moonSign, comment: ""))
            moonData.sunSign = String(format: NSLocalizedString(decoded.moon.zodiac.sunSign, comment: ""))
 
            moonData.emoji = decoded.moon.emoji

            moonData.illumination = decoded.moon.illumination
            
            moonData.daysUntilNextFullMoon = signedDaysBetweenUnixTimestamps(
                decoded.timestamp,
                decoded.moon.detailed.upcomingPhases.fullMoon.next.timestamp ?? 0
            )
            
            // Safely format timestamps if present
            moonData.moonrise = formatTimeIfPresent(decoded.moon.moonriseTimestamp)
            moonData.moonset  = formatTimeIfPresent(decoded.moon.moonsetTimestamp)
            
            moonData.distance = decoded.moon.detailed.position.distance
            
            // Format upcoming full/new moon timestamps if present
            moonData.fullMoon =
            formatTimestamp(timestamp: TimeInterval(decoded.moon.detailed.upcomingPhases.fullMoon.next.timestamp ?? 0),
                            offsetSec: offsetSec)
            
            moonData.newMoon =
            formatTimestamp(timestamp: TimeInterval(decoded.moon.detailed.upcomingPhases.newMoon.next.timestamp ?? 0),
                            offsetSec: offsetSec)
            
        } catch {
            print("Decoding RapidAdvanced error:", error)
        }
        
    } catch {
        print("Request failed with error: \(error)")
    }
    
    return moonData
}
