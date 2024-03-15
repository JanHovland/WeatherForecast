//
//  AverageDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation

struct AverageDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    @State private var averageDailyDataRecord = AverageDailyDataRecord(time: [""],
                                                                       precipitationSum: [0.00],
                                                                       temperature2MMin: [0.00],
                                                                       temperature2MMax: [0.00],
                                                                       temperature2MMean: [0.00])
    
    @State private var averageHourlyDataRecord = AverageHourlyDataRecord(time: [""],
                                                                         precipitation: [0.00],
                                                                         temperature2M: [0.00])
    
    @State private var averageYearMin: [Double] = Array(repeating: Double(), count: sizeArray12)
    @State private var averageYearMax: [Double] = Array(repeating: Double(), count: sizeArray12)
    @State private var averageYearMean: [Double] = Array(repeating: Double(), count: sizeArray12)
    @State private var averageYearPrecification: [Double] = Array(repeating: Double(), count: sizeArray12)
    
    @State private var averageHourlyPrecipitation = [Double]()
    @State private var averageHourlyTemperature2M = [Double]()

    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("Average")
                Spacer()
            }
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 20)
                        })
                    }
                }
            }
            .offset(y: UIDevice.isIpad ? -22.5 : -22.5)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("1sdfghjkløkjhgf")
                    Text("2sdfghjkløkjhgf")
                    Text("3sdfghjkløkjhgf")
                    Text("4sdfghjkløkjhgf")
                    Text("5sdfghjkløkjhgf")
                    Text("6sdfghjkløkjhgf")
                    Text("7sdfghjkløkjhgf")
                    Text("8sdfghjkløkjhgf")
                    Text("9sdfghjkløkjhgf")
                    Text("10sdfghjkløkjhgf")
                    Text("11sdfghjkløkjhgf")
                    Text("12sdfghjkløkjhgf")
                    Text("13sdfghjkløkjhgf")
                    Text("14sdfghjkløkjhgf")
                    Text("14sdfghjkløkjhgf")
                    
                    Spacer()
                }
                
            } /// ScrollView
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        .onAppear() {
            Task.init {
                ///
                /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
                ///
                let urlSession = URLSession.shared
                ///
                /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31
                ///
                /*
                 Ny normal i klimaforskningen
                 16.12.2020 | Endret 18.1.2021
                 Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar utgangspunkt i når vi snakker om hva som er normalt vær. Tidligere har vi brukt 1961-1990.
                 Hvorfor bytter vi normalperiode?
                 I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO) om at en trengte en felles referanse for klima, såkalte standard normaler.. De ble enige om at hver periode skulle vare 30 år. På den måten sikret man en lang nok dataperiode, men unngikk påvirkning fra kortvarige variasjoner. Den første  normalperioden skulle gå fra 1901 - 1930. Det ble også enighet om at normalene skulle byttes hvert 30. år.
                 I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år, men nå skal byttes hvert 10. år på grunn av klimaendringene. Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger reflekterer det vanlige været i et område. Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere enn før for at de bedre skal beskrive det aktuelle klimaet.
                 */
                
                let a = "https://archive-api.open-meteo.com/v1/archive?latitude="
                let b = "&timezone=auto&daily=precipitation_sum,temperature_2m_min,temperature_2m_max,temperature_2m_mean"
                let startDate = "1991-01-01"
                let endDate   = "2020-12-31"
                let lat = "\(58.6173)"
                let lon = "\(5.6450)"
                ///
                /// Husk å sette timezone=auto for å riktig tidssone
                ///
                let urlString =
                a + lat + "&longitude=" + lon + b + "&start_date=" + startDate + "&end_date=" + endDate
                let url = URL(string: urlString)
                let (jsonData, _) = try await urlSession.data(from: url!)
                let data = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData)
                
                if data == nil {
                    logger.notice("nil Data, please try one more time !!!")
                } else {
                    
                    logger.notice("Stop fetching")
                    ///
                    /// Resetter
                    ///
                    averageDailyDataRecord.time.removeAll()
                    averageDailyDataRecord.precipitationSum.removeAll()
                    averageDailyDataRecord.temperature2MMin.removeAll()
                    averageDailyDataRecord.temperature2MMax.removeAll()
                    averageDailyDataRecord.temperature2MMean.removeAll()
                    ///
                    /// Oppdaterer
                    ///
                    averageDailyDataRecord.time = (data?.daily.time)!
                    averageDailyDataRecord.precipitationSum = (data?.daily.precipitationSum)!
                    averageDailyDataRecord.temperature2MMin = (data?.daily.temperature2MMin)!
                    averageDailyDataRecord.temperature2MMax = (data?.daily.temperature2MMax)!
                    averageDailyDataRecord.temperature2MMean = (data?.daily.temperature2MMean)!
                    
                    
                    
                    ///
                    /// Find average yearly data
                    ///
                    (averageYearMin,
                     averageYearMax,
                     averageYearMean,
                     averageYearPrecification) = FindAverageYear(averageDailyTime: averageDailyDataRecord.time,
                                                                 avarageDailyMin: averageDailyDataRecord.temperature2MMin,
                                                                 avarageDailyMax: averageDailyDataRecord.temperature2MMax,
                                                                 averageDailyMean: averageDailyDataRecord.temperature2MMean,
                                                                 aveargePercification: averageDailyDataRecord.precipitationSum)
                    
                    
                    
                    //                    logger.notice("Average ** min temp for mars ** = \(averageYearMin)")
                    //                    logger.notice("Average max temp for mars = \(averageYearMax[2])")
                    //                    logger.notice("Average mean temp for mars = \(averageYearMean[2])")
                    logger.notice("Total ** precification** for januar = \(averageYearPrecification[0])")
                    logger.notice("Total ** precification** for februar = \(averageYearPrecification[1])")
                    logger.notice("Total ** precification** for mars = \(averageYearPrecification[2])")
                    logger.notice("Total ** precification** for april = \(averageYearPrecification[2])")
                }
                //
                //                logger.notice("Start fetching hourly")
                //
                //                let urlString1 =  "https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&timezone=auto&start_date=2013-03-12&end_date=2023-03-12&hourly=precipitation,temperature_2m"
                //
                //                let url1 = URL(string: urlString1)
                //                let (jsonData1, _) = try await urlSession.data(from: url1!)
                //                let data1 = try? JSONDecoder().decode(AverageHourlyData.self, from: jsonData1)
                //
                //                logger.notice("Stop fetching hourly")
                //
                //                averageHourlyDataRecord.time.removeAll()
                //                averageHourlyDataRecord.precipitation.removeAll()
                //                averageHourlyDataRecord.temperature2M.removeAll()
                //
                //                averageHourlyPrecipitation.removeAll()
                //                averageHourlyTemperature2M.removeAll()
                //
                //                averageHourlyDataRecord.time = (data1?.hourly.time)!
                //                averageHourlyDataRecord.precipitation = (data1?.hourly.precipitation)!
                //                averageHourlyDataRecord.temperature2M = (data1?.hourly.temperature2M)!
                //
                //
                //                for i in 0..<averageHourlyDataRecord.time.count {
                //                    if averageHourlyDataRecord.time[i].contains("-03-12") {
                //                        averageHourlyPrecipitation.append(averageHourlyDataRecord.precipitation[i])
                //                        averageHourlyTemperature2M.append(averageHourlyDataRecord.temperature2M[i])
                //                    }
                //                }
                //
                //                logger.notice("After the for-loop -03-12")
                //
                //                logger.notice("count precification = \(averageHourlyPrecipitation.count)")
                //                logger.notice("count temperature2M = \(averageHourlyTemperature2M.count)")
                //
                //
                //                logger.notice("Number of elements = \(averageHourlyDataRecord.time.count)")
                //                logger.notice("Average hourly precipitation = \(FindAverageArray(array: averageHourlyPrecipitation))")
                //                logger.notice("Average hourly temperature2M = \(FindAverageArray(array: averageHourlyTemperature2M))")
                //                logger.notice("Average hourly min temperature2M = \(averageHourlyTemperature2M.min()!)")
                //                logger.notice("Average hourly max temperature2M = \(averageHourlyTemperature2M.max()!)")
                
            }
        }

    }
}
