//
//  CountriesView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/01/2024.
//

import SwiftUI
import Foundation


///
/// https://blog.stackademic.com/search-data-in-swiftui-list-view-c62e990b3a32
///

struct CountriesView: View {
    
    @State private var countries: [CountryRecord] = []
    @State private var searchText = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    
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
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { item in
                    LazyHStack (alignment: .top, spacing: UIDevice.isIpad ? 100 : 10) {
                        VStack (alignment: .leading) {
                            Text("Country: ")
                            Text("Land code: ")
                            Text("Flag: ")
                            Text("Capitol: ")
                            Text("Population: ")
                        }
                        .foregroundStyle(.green)
                        VStack (alignment: .leading) {
                            Text(item.name)
                                .foregroundStyle(.green)
                                .modifier(CountryName(name: item.name, length: 35))
                            Text(item.code)
                            Text(item.flag)
                            if item.capital == "Unknown" {
                                let capital = String(localized: "Unknown")
                                Text(capital)
                                    .foregroundStyle(.red)
                            } else {
                                Text(item.capital)
                            }
                            Text("\(item.population)")
                        }
                    }
                    .font(.subheadline)
                    .padding(2)
                }
            }
            .searchable(text: $searchText)
            .listStyle(.inset)
            .scrollIndicators(.hidden)
        }
        .padding(.leading, 10)
        .navigationBarTitle("Countries overview")
        .navigationBarTitleDisplayMode(.inline)
        .alert(title, isPresented: $showAlert) {
            }
            message: {
                Text(message)
        }
        .task {
            
            Task.init {
                
                ///
                /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
                ///
                logger.notice("Start")
                
                let urlSession = URLSession.shared
                ///
                /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31 = 10957 dager
                ///
                
                let normalPerioden =
                    """
                    Ny normal i klimaforskningen
                    16.12.2020 | Endret 18.1.2021
                    Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar utgangspunkt i når vi snakker om hva som er normalt vær. Tidligere har vi brukt 1961-1990.
                    Hvorfor bytter vi normalperiode?
                    I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO) om at en trengte en felles referanse for klima, såkalte standard normaler.. De ble enige om at hver periode skulle vare 30 år. På den måten sikret man en lang nok dataperiode, men unngikk påvirkning fra kortvarige variasjoner. Den første  normalperioden skulle gå fra 1901 - 1930. Det ble også enighet om at normalene skulle byttes hvert 30. år.
                    I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år, men nå skal byttes hvert 10. år på grunn av klimaendringene. Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger reflekterer det vanlige været i et område. Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere enn før for at de bedre skal beskrive det aktuelle klimaet.
                    """
                
                let a = "https://archive-api.open-meteo.com/v1/archive?latitude="
                let b = "&timezone=auto&daily=precipitation_sum,temperature_2m_min,temperature_2m_max,temperature_2m_mean"
                
                
                let startDate = "1991-01-01"
                let endDate = "2020-12-31"
                
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
                    ///
                    ///
                    
                    (averageYearMin[7],
                     averageYearMax[7],
                     averageYearMean[7],
                     averageYearPrecification[7]) =
                    MeanTemperatureMonth(averageDailyTime: averageDailyDataRecord.time,
                                                            avarageDailyMin: averageDailyDataRecord.temperature2MMin,
                                                            avarageDailyMax: averageDailyDataRecord.temperature2MMax,
                                                            averageDailyMean: averageDailyDataRecord.temperature2MMean,
                                                            aveargePercification: averageDailyDataRecord.precipitationSum,
                                                            month: 8)
                    
                    logger.notice("Average min temp for august = \(averageYearMin[7])")
                    logger.notice("Average max temp for august = \(averageYearMax[7])")
                    logger.notice("Average mean temp for august = \(averageYearMean[7])")
                    logger.notice("Average precification for august = \(averageYearPrecification[7])")

                    
                }
                
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
            
            /// Beskrivelse av feltene for:
            /// https://restcountries.com/v3.1/all?fields=
            ///
            /// https://gitlab.com/restcountries/restcountries/-/blob/master/FIELDS.md
            ///
            
            let url1 = UserDefaults.standard.object(forKey: "UrlRestCountries") as? String ?? ""
            if url1 == "" {
                Task.init {
                    title = "Update setting for RestCountries."
                    showAlert.toggle()
                }
            } else {
                var value1: (String, [CountryRecord])
                await value1 = FindCountries(urlString: url1)
                if value1.0 == "" {
                    countries = value1.1
                } else {
                    countries.removeAll()
                }
            }
        }
        ///
        /// Sort list using search text
        ///
        var searchResults: [CountryRecord] {
            if searchText.isEmpty {
                return countries
            } else {
                return countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
    }

    func MeanTemperatureMonth (averageDailyTime: [String],
                               avarageDailyMin: [Double],
                               avarageDailyMax: [Double],
                               averageDailyMean: [Double],
                               aveargePercification: [Double],
                               month: Int) -> (Double,
                                               Double,
                                               Double,
                                               Double) {
        
        var valueMin = Double()
        var valueMax = Double()
        var valueMean = Double()
        var valuePrecification = Double()
        
        var monthSelected: String = ""
        
        var averageDailyTemperatureMin = [Double]()
        var averageDailyTemperatureMax = [Double]()
        var averageDailyTemperatureMean = [Double]()
        var averageDailyPrecipitation = [Double]()

        
        if month < 10 {
            monthSelected = "-0" + String(month) + "-"
        } else {
            monthSelected = "-" + String(month) + "-"
        }
        
        averageDailyTemperatureMin.removeAll()
        averageDailyTemperatureMax.removeAll()
        averageDailyTemperatureMean.removeAll()
        averageDailyPrecipitation.removeAll()

        for i in 0..<averageDailyTime.count {
            if averageDailyTime[i].contains(monthSelected) {
                averageDailyTemperatureMin.append(avarageDailyMin[i])
                averageDailyTemperatureMax.append(avarageDailyMax[i])
                averageDailyTemperatureMean.append(averageDailyMean[i])
                averageDailyPrecipitation.append(aveargePercification[i])
            }
        }

        valueMin = FindAverageArray(array: averageDailyTemperatureMin)
        valueMax = FindAverageArray(array: averageDailyTemperatureMax)
        valueMean = FindAverageArray(array: averageDailyTemperatureMean)
        valuePrecification = FindAverageArray(array: averageDailyPrecipitation)
        
        return (valueMin, valueMax, valueMean, valuePrecification)
    }

}
