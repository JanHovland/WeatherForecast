//
//  GetAverageMonthlyWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/03/2024.
//

import Foundation
import SwiftUI

func GetAverageMonthlyWeather(urlPart1: String,
                              urlPart2: String,
                              startDate: String,
                              endDate: String,
                              lat: Double,
                              lon: Double) async -> (String,
                                                     AverageMonthlyDataRecord) {
    
    var errorMessage: String = ""
    var averageMonthlyDataRecord = AverageMonthlyDataRecord(time: [""],
                                                            precipitationSum: [0.00],
                                                            temperature2MMin: [0.00],
                                                            temperature2MMax: [0.00],
                                                            temperature2MMean: [0.00])
    
    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    let urlSession = URLSession.shared
    ///
    /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31
    ///
    ///     Ny normal i klimaforskningen:
    ///     16.12.2020 | Endret 18.1.2021
    ///     Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar utgangspunkt i når vi snakker om hva som er normalt vær.
    ///     Tidligere har vi brukt 1961-1990.
    ///     Hvorfor bytter vi normalperiode?
    ///     I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO) om at en trengte en felles referanse for klima,
    ///     såkalte standard normaler.. De ble enige om at hver periode skulle vare 30 år.
    ///     På den måten sikret man en lang nok dataperiode, men unngikk påvirkning fra kortvarige variasjoner.
    ///     Den første  normalperioden skulle gå fra 1901 - 1930.
    ///     Det ble også enighet om at normalene skulle byttes hvert 30. år.
    ///     I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år,
    ///     men nå skal byttes hvert 10. år på grunn av klimaendringene.
    ///     Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger reflekterer det vanlige været i et område.
    ///     Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere enn før for at
    ///     de bedre skal beskrive det aktuelle klimaet.
    ///
    /// Husk å sette timezone=auto for å riktig tidssone
    ///
    let urlString =
    urlPart1 + "\(lat)" + "&longitude=" + "\(lon)" + urlPart2 + "&start_date=" + startDate + "&end_date=" + endDate
    let url = URL(string: urlString)
    logger.notice("urlString = \(urlString)")
    ///
    /// Henter gjennomsnittsdata
    ///
    do {
        logger.notice("Start fetching data")
        let (jsonData, _) = try await urlSession.data(from: url!)
        let data = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData)
        if data == nil {
            logger.notice("No available average data.")
            errorMessage = "No available average data."
        } else {
            logger.notice("Stop fetching data")
            ///
            /// Resetting av data
            ///
            averageMonthlyDataRecord.time.removeAll()
            averageMonthlyDataRecord.precipitationSum.removeAll()
            averageMonthlyDataRecord.temperature2MMin.removeAll()
            averageMonthlyDataRecord.temperature2MMax.removeAll()
            averageMonthlyDataRecord.temperature2MMean.removeAll()
            ///
            /// Oppdatering av averageMonthlyDataRecord
            ///
            averageMonthlyDataRecord.time = (data?.daily.time)!
            averageMonthlyDataRecord.precipitationSum = (data?.daily.precipitationSum)!
            averageMonthlyDataRecord.temperature2MMin = (data?.daily.temperature2MMin)!
            averageMonthlyDataRecord.temperature2MMax = (data?.daily.temperature2MMax)!
            averageMonthlyDataRecord.temperature2MMean = (data?.daily.temperature2MMean)!
            ///
            /// Find average yearly data
            ///
            (averageMonthMin,
             averageMonthMax,
             averageMonthMean,
             averageMonthPrecification) = FindAverageYear(averageDailyTime: averageMonthlyDataRecord.time,
                                                          avarageDailyMin: averageMonthlyDataRecord.temperature2MMin,
                                                          avarageDailyMax: averageMonthlyDataRecord.temperature2MMax,
                                                          averageDailyMean: averageMonthlyDataRecord.temperature2MMean,
                                                          aveargePercification: averageMonthlyDataRecord.precipitationSum)
        }
    } catch {
        logger.notice("Errors = \(error)")
    }
    ///
    /// Returnerer data
    ///
    return (errorMessage, averageMonthlyDataRecord)
}


