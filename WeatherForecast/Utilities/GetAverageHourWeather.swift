//
//  GetAverageHourWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/04/2024.
//

import Foundation
import SwiftUI

func GetAverageHourWeather(year: Int,
                           date: String,
                           lat: Double,
                           lon: Double) async -> (LocalizedStringKey,
                                                  AverageHourlyDataRecord) {
    
    ///
    /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31
    ///
    ///     Ny normal i klimaforskningen:
    ///     16.12.2020 | Endret 18.1.2021
    ///     Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar
    ///     utgangspunkt i når vi snakker om hva som er normalt vær.
    ///     Tidligere har vi brukt 1961-1990.
    ///     Hvorfor bytter vi normalperiode?
    ///     I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO)
    ///     om at en trengte en felles referanse for klima,
    ///     såkalte standard normaler.
    ///     De ble enige om at hver periode skulle vare 30 år.
    ///     På den måten sikret man en lang nok dataperiode, men unngikk påvirkning
    ///     fra kortvarige variasjoner.
    ///     Den første  normalperioden skulle gå fra 1901 - 1930.
    ///     Det ble også enighet om at normalene skulle byttes hvert 30. år.
    ///     I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år,
    ///     men nå skal byttes hvert 10. år på grunn av klimaendringene.
    ///     Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger
    ///     reflekterer det vanlige været i et område.
    ///     Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere
    ///     enn før for at de bedre skal beskrive det aktuelle klimaet.

    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    let forDate = String(year) + date
    
    var averageHourlyDataRecord = AverageHourlyDataRecord(time: [""],
                                                          temperature2M: [0.00])

    let part1 = UserDefaults.standard.object(forKey: "Url1OpenMeteo") as? String ?? ""
    
    let urlString = part1 + "\(lat)" + "&longitude=" + "\(lon)" +
    "&timezone=auto" + "&hourly=temperature_2m" + "&start_date=" + forDate + "&end_date=" + forDate

    let url = URL(string: urlString)
    
    ///
    /// Henter gjennomsnittsdata
    ///
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, response) = try await urlSession.data(from: url)
            ///
            /// Finner statusCode fra response
            ///
            let res = response as? HTTPURLResponse
            httpStatus = res!.statusCode
            ///
            /// 200 OK
            /// The request succeeded.
            ///
            /// 400 Bad Request
            /// The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
            ///
            if httpStatus > 200,
               httpStatus <= 499 {
                if httpStatus == 400 {
                    let msg = String(localized: "400 = Bad Request")
                    errorMessage = LocalizedStringKey(msg)
                } else if httpStatus == 429 {
                    let msg = String("429 = Too Many Requests, the user has sent too many requests in a given amount of time (\"rate limiting\")")
                    errorMessage = LocalizedStringKey(msg)
                } else {
                    let msg = "\(httpStatus)"
                    errorMessage = LocalizedStringKey(msg)
                }
            } else {
                if let averageData = try? JSONDecoder().decode(AverageHourlyData.self, from: jsonData) {
                    ///
                    /// Oppdatering av averageHourlyDataRecord
                    ///
                    averageHourlyDataRecord.time = averageData.hourly.time
                    averageHourlyDataRecord.temperature2M = averageData.hourly.temperature2M
                } else {
                    let msg = String(localized: "Can not find any average data")
                    errorMessage = LocalizedStringKey(msg)
                }
            }
        } catch {
            debugPrint(error)
        }
    }
    
    return (errorMessage, averageHourlyDataRecord)
}

