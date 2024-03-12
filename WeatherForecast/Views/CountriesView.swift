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
    @State private var averageDailyPrecipitation = [Double]()
    @State private var averageDailyTemperatureMin = [Double]()
    @State private var averageDailyTemperatureMax = [Double]()
    @State private var averageDailyTemperatureMean = [Double]()

    @State private var averageHourlyDataRecord = AverageHourlyDataRecord(time: [""],
                                                                         precipitation: [0.00],
                                                                         temperature2M: [0.00])
    
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
                
                ///
                /// Husk å sette timezone=auto for å riktig tidssone
                ///
//                let urlString = "https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&timezone=auto&start_date=1994-01-01&end_date=2023-12-31&daily=temperature_2m_mean"
//                let urlString = "https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&timezone=auto&start_date=2023-12-01&end_date=2023-12-31&daily=temperature_2m_mean,precipitation_unit"

                let urlString =  "https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&timezone=auto&start_date=1994-05-01&end_date=2023-05-31&daily=precipitation_sum,temperature_2m_min,temperature_2m_max,temperature_2m_mean"
               
                
                let url = URL(string: urlString)
                let (jsonData, _) = try await urlSession.data(from: url!)
                let data = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData)
                
                if data == nil {
                    logger.notice("nil Data, please try one more time !!!")
                } else {
                    
                    logger.notice("Stop fetching")
                    
                    averageDailyDataRecord.time.removeAll()
                    averageDailyDataRecord.precipitationSum.removeAll()
                    averageDailyDataRecord.temperature2MMin.removeAll()
                    averageDailyDataRecord.temperature2MMax.removeAll()
                    averageDailyDataRecord.temperature2MMean.removeAll()

                    averageDailyPrecipitation.removeAll()
                    averageDailyTemperatureMin.removeAll()
                    averageDailyTemperatureMax.removeAll()
                    averageDailyTemperatureMean.removeAll()
                    
                    averageDailyDataRecord.time = (data?.daily.time)!
                    averageDailyDataRecord.precipitationSum = (data?.daily.precipitationSum)!
                    averageDailyDataRecord.temperature2MMin = (data?.daily.temperature2MMin)!
                    averageDailyDataRecord.temperature2MMax = (data?.daily.temperature2MMax)!
                    averageDailyDataRecord.temperature2MMean = (data?.daily.temperature2MMean)!

                    for i in 0..<averageDailyDataRecord.time.count {
                        if averageDailyDataRecord.time[i].contains("-05-") {
                            averageDailyPrecipitation.append(averageDailyDataRecord.precipitationSum[i])
                            averageDailyTemperatureMin.append(averageDailyDataRecord.temperature2MMin[i])
                            averageDailyTemperatureMax.append(averageDailyDataRecord.temperature2MMax[i])
                            averageDailyTemperatureMean.append(averageDailyDataRecord.temperature2MMean[i])
                        }
                    }
                    
                    logger.notice("Number of elements = \(averageDailyDataRecord.temperature2MMax.count)")
                    logger.notice("Average min temp   = \(FindAverageArray(array: averageDailyTemperatureMin))")
                    logger.notice("Average max temp   = \(FindAverageArray(array: averageDailyTemperatureMax))")
                    logger.notice("Average mean temp  = \(FindAverageArray(array: averageDailyTemperatureMean))")

                    // logger.notice("Average precipitation = \(FindAverageArray(array: averageDailyPrecipitation))")

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
}
