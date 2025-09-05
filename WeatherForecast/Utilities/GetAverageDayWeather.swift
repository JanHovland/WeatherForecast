//
//  GetAverageWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/03/2024.
//

import Foundation
import SwiftUI

func GetAverageDayWeather(option: EnumType,
                          placeName: String,
                          years: Int,
                          startDate: String,
                          endDate: String,
                          lat: Double,
                          lon: Double) async -> (LocalizedStringKey,
                                                 AverageDailyDataRecord) {
    
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
    var fileName: String = ""
    var fileDoesExist: Bool = false
    var averageDailyDataRecord = AverageDailyDataRecord(time: [""],
                                                        precipitationSum: [0.00],
                                                        temperature2MMin: [0.00],
                                                        temperature2MMax: [0.00])
    ///
    /// finner fileName
    ///
    fileDoesExist = false
    if option == .years {
        fileName = placeName + " " + "\(lat)" + " " + "\(lon)" + " " + "\(years)" + " " + yearNumbers + ".json"
        ///
        /// Sjekker om fileName finnes
        ///
        let value : (LocalizedStringKey, Bool) = fileExist(named: fileName)
        if value.0 == "", value.1 == true {
            ///
            /// filen finnes
            ///
            fileDoesExist = value.1
        }
    }
    ///
    /// Finner urlPart1 fra Settings()
    ///
    let urlPart1 = UserDefaults.standard.object(forKey: "Url1OpenMeteo") as? String ?? ""
    if urlPart1 == "" {
        let msg = String(localized: "Update setting for OpenMeteo 1.")
        errorMessage = LocalizedStringKey(msg)
    }
    ///
    /// Finner urlPart2 fra Settings()
    ///
    let urlPart2 = UserDefaults.standard.object(forKey: "Url2OpenMeteo") as? String ?? ""
    if urlPart2 == "" {
        let msg = String(localized: "Update the setting for OpenMeteo 2.")
        errorMessage = LocalizedStringKey(msg)
    }
    ///
    /// Feilmelding dersom urlPart1 og / eller urlPart2 ikke har verdi
    ///
    if urlPart1.count > 0, urlPart2.count > 0 {
        let urlString =
        urlPart1 + "\(lat)" + "&longitude=" + "\(lon)" + urlPart2 + "&start_date=" + startDate + "&end_date=" + endDate
        let url = URL(string: urlString)
        ///
        /// Henter gjennomsnittsdata
        ///
        if option == .years && fileDoesExist == true {
            ///
            /// Lagrer averageDailyDataRecord i **ileName**
            ///
            let average = loadAverageData(fileName)
            averageDailyDataRecord.time = average!.time
            averageDailyDataRecord.precipitationSum = average!.precipitationSum
            averageDailyDataRecord.temperature2MMin = average!.temperature2MMin
            averageDailyDataRecord.temperature2MMax = average!.temperature2MMax
        } else if option == .days || option == .years && fileDoesExist == false {
            if let url {
                do {
                    let urlSession = URLSession.shared
                    let (jsonData, response) = try await urlSession.data(from: url)
                    errorMessage = ServerResponse(error:"\(response)")
                    ///
                    /// Finner statusCode fra response
                    ///
                    let res = response as? HTTPURLResponse
                    httpStatus = res!.statusCode
                    ///
                    /// Sjekker httpStatus
                    ///
                    if httpStatus == 200 {
                        if let averageData = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData) {
                            ///
                            /// Oppdatering av averageDailyDataRecord
                            ///
                            averageDailyDataRecord.time = (averageData.daily.time)
                            averageDailyDataRecord.precipitationSum = (averageData.daily.precipitationSum)
                            averageDailyDataRecord.temperature2MMin = (averageData.daily.temperature2MMin)
                            averageDailyDataRecord.temperature2MMax = (averageData.daily.temperature2MMax)
                            errorMessage = ""
                            ///
                            /// Lagrer data i Document directory
                            ///
                            if option == .years && fileDoesExist == false {
                                saveAverageData(fileName, data: averageDailyDataRecord)
                            }
                        } else {
                            let msg = String(localized: "Can not find any average data")
                            errorMessage = LocalizedStringKey(msg)
                        }
                    } else {
                        errorMessage = ServerResponse(error:"\(response)")
                    }
                } catch {
                    let response = CatchResponse(response: "\(error)",
                                                 searchFrom: "Code=",
                                                 searchTo: "UserInfo")
                    errorMessage = "\(response)"
                }
            }
        }
    }
    return (errorMessage, averageDailyDataRecord)
}
