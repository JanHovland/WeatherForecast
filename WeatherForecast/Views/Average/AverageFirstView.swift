//
//  AverageFirstView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI

struct AverageFirstView: View {
    
    
    /// https://www.yr.no/nb/historikk/graf/1-8324/Norge/Rogaland/Hå/Varhaug?q=siste-30-dager
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var isTemperature: Bool = false
    @State private var errorMessage: LocalizedStringKey = ""
    @State private var normalLowTemp: Double = 0.00
    @State private var normalMeanTemp: Double = 0.00
    @State private var normalHighTemp: Double = 0.00
    
    @State private var sumMinTemp: Double = 0.00
    @State private var sumMeanTemp: Double = 0.00
    @State private var sumMaxTemp: Double = 0.00
    
    @State private var deviationTemp: Int = 0
    
    @State private var counterMin = 0
    @State private var counterMean = 0
    @State private var counterMax = 0
    
    @State private var fromDate: String = ""
    @State private var toDate: String = ""
    
    @State private var precificationLast30Days: Double = 0.00
    @State private var precificationNormalLast30Days: Double = 0.00
    
    @State private var toDayAverageTemperatureArray: [AverageTemperature] = []
    @State private var toDayAverageMinTemperatureArray: [AverageHourMinTemperature] = []
    @State private var toDayAverageMaxTemperatureArray: [AverageHourMaxTemperature] = []
    
    @State private var todayFrom: Date = Date()
    @State private var todayTo: Date = Date()
    
    @State private var minAverageHourArray: [Double] = []
    @State private var maxAverageHourArray: [Double] = []
    
    @State private var averageHourlyDataRecord = AverageHourlyDataRecord(time: [""],
                                                                         temperature2M: [0.00])
    
    @State private var doubleTempertureArray: [[Double]] = []
    
    @State private var averageJanuaryData = AverageMonthlyData()
    @State private var averageFebruaryData = AverageMonthlyData()
    @State private var averageMarsData = AverageMonthlyData()
    @State private var averageAprilData = AverageMonthlyData()
    @State private var averageMayData = AverageMonthlyData()
    @State private var averageJuneData = AverageMonthlyData()
    @State private var averageJulyData = AverageMonthlyData()
    @State private var averageAugustData = AverageMonthlyData()
    @State private var averageSeptemberData = AverageMonthlyData()
    @State private var averageOctoberData = AverageMonthlyData()
    @State private var averageNovemberData = AverageMonthlyData()
    @State private var averageDecemberData = AverageMonthlyData()
    
    @State private var averageDailyData30DaysRecord = AverageDailyData30DaysRecord(date: [""], precipitation:  [0.00])
    
    @State private var averageDailyYearDataRecord = AverageDailyYearDataRecord(time: [""],
                                                                               precipitationSum: [0.00])
    
    @State private var averagePrecipitationOverYears: [PrecipitationOverYears] = []
    @State private var averagePrecipitationNormalYears: [AveragePrecipitationNormalYears] = []
    
    
    @State private var averageNormalPrecipitationMonth: [AverageNormalPrecipitationMonth] = []
    
    @State private var divisor: Double = 10.00
    
    @State private var maxx: Double = 0.00
    @State private var minx: Double = 0.00
    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("AVERAGES")
                Spacer()
            }
            .opacity(0.50)
            HStack {
                if weatherInfo.dailyDeviationTemp > 0  {
                    Text("\(String(describing: weatherInfo.dailyDeviationTemp))º")
                    Text(String(localized: "above the normal highest daytime temperature."))
                } else if weatherInfo.dailyDeviationTemp < 0  {
                    Text("\(String(describing: abs(weatherInfo.dailyDeviationTemp)))º")
                    Text(String(localized: "under the normal highest daytime temperature."))
                } else {
                    Text(String(localized: "Same as the normal highest daytime temperature."))
                }
            }
            .padding(.bottom, 10)
            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .light))
            HStack {
                HStack {
                    Text(String(localized: "H: Today"))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(String(format: "%.0f", round(weatherInfo.highTemperature ?? 0.00)) + "º")
                }
            }
            HStack {
                HStack {
                    Text(String(localized: "H: Average"))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(String(format: "%.0f", round(normalHighTemp)) + "º")
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .fullScreenCover(isPresented: $isTemperature, content: {
            AverageView()
                .background(Color("Background#01").opacity(currentWeather.isDaylight == true ? 0.60 : 0.35))
            //                .presentationBackground(alignment: .bottom) {
            //                    LinearGradient(colors: [Color.lightBlue, Color.darkBlue], startPoint: .top, endPoint: .bottom)
            //                }
        })
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        .onAppear {
            Task.init {
                counterMin = 0
                counterMax = 0
                
                sumMinTemp = 0.00
                sumMaxTemp = 0.00
                ///
                /// Formatterer dato i dag
                ///
                let from = FormatDateToString(date:  GetLocalDate(date: Date()), format: "-MM-dd", offsetSec: 0)
                ///
                /// Finner gjennomsnittet for de 10/30  siste årene for average10YearsDataRecord.temperature2MMax
                ///
                for i in 0..<averageYearsPerDayDataRecord.time.count {
                    if averageYearsPerDayDataRecord.time[i].contains(from) {
                        if averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00 > 0.00 {
                            counterMin += 1
                            sumMinTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        }
                        if averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00 > 0.00 {
                            counterMax += 1
                            sumMaxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        }
                    }
                }
                ///
                /// Finner normalt høyeste og laveste temperatur
                ///
                normalLowTemp = sumMinTemp / Double(counterMin)
                normalMeanTemp = sumMeanTemp / Double(counterMean)
                normalHighTemp = sumMaxTemp / Double(counterMax)
                ///
                /// Finner differansen mellom dagens høyeste temperatur og normalt høyeste temperatur
                ///
                if normalHighTemp > 0.00 {
                    deviationTemp = Int(round(weatherInfo.highTemperature ?? 0.00) - round(normalHighTemp))
                }
                ///
                /// Finner månedlige normaltemperaturer
                ///
                ///
                /// Formatterer month i dag
                ///
                let month = FormatDateToString(date:  GetLocalDate(date: Date()), format: "-MM-", offsetSec: 0)
                ///
                /// Finner gjennomsnittet for aktuell måned de 10 siste årene
                ///
                counterMin = 0
                counterMax = 0
                sumMinTemp = 0.00
                sumMaxTemp = 0.00
                for i in 0..<averageYearsPerDayDataRecord.time.count {
                    if averageYearsPerDayDataRecord.time[i].contains(month) {
                        if averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00 > 0.00 {
                            counterMin += 1
                            sumMinTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        }
                        if averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00 > 0.00 {
                            counterMax += 1
                            sumMaxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        }
                    }
                }
                ///
                /// Finner nedbøren siste 30 dagene
                ///
                (errorMessage,
                 fromDate,
                 toDate,
                 average30DaysDataRecord) = await FindDataLast30Days(placeName: weatherInfo.placeName,
                                                                     lat: weatherInfo.latitude ?? 0.00,
                                                                     lon: weatherInfo.longitude ?? 0.00)
                if errorMessage == "" {
                    precificationLast30Days = 0.00
                    for i in 0..<average30DaysDataRecord.time.count {
                        precificationLast30Days += average30DaysDataRecord.precipitationSum[i] ?? 0.00
                    }
                } else {
                    precificationLast30Days = 0.00
                }
                ///
                /// Finner akkumulert nedbørsmengde pr dag i 30 dagers perioden
                ///
                averageDailyData30DaysRecord.date.removeAll()
                averageDailyData30DaysRecord.precipitation.removeAll()
                
                var sum: Double = 0.00
                var tot: Double = 0.00
                
                for i in 0..<average30DaysDataRecord.time.count {
                    let date = average30DaysDataRecord.time[i]
                    sum = average30DaysDataRecord.precipitationSum[i] ?? 0.00
                    tot += sum
                    averageDailyData30DaysRecord.date.append(date)
                    averageDailyData30DaysRecord.precipitation.append(tot)
                }
                ///
                /// Tilpasser Precification30DaysAccumulated til Chart
                ///
                var u = Precipitation30DaysAccumulated(id: UUID(),
                                                       precipitation: 0.00,
                                                       type: "",
                                                       index: 0,
                                                       date: "")
                var precipitation30DaysAccumulated: [Precipitation30DaysAccumulated] = []
                precipitation30DaysAccumulated.removeAll()
                let count2 = averageDailyData30DaysRecord.precipitation.count
                for i in 0..<count2 {
                    u.id = UUID()
                    u.precipitation = averageDailyData30DaysRecord.precipitation[i]
                    u.type = String(localized: "Precipitation")
                    u.index = i
                    u.date = averageDailyData30DaysRecord.date[i]
                    precipitation30DaysAccumulated.append(u)
                }
                weatherInfo.precipitation30DaysAccumulated = precipitation30DaysAccumulated
                ///
                /// Finner normal nedbøren de siste 10 årene
                ///
                precificationNormalLast30Days = 0.00
                for year in 2011...2020 {
                    let selectedYear = String(year)
                    precificationNormalLast30Days +=
                    FindPrecificationForPeriode(averageYearsDataRecord: averageYearsPerDayDataRecord,
                                                year: selectedYear,
                                                fromDate: fromDate,
                                                toDate: toDate)
                }
                precificationNormalLast30Days = precificationNormalLast30Days / 10.0
                ///
                /// Oppdaterer weatherInfo med temperaturene
                ///
                weatherInfo.normalDailyLowTemp = normalLowTemp
                weatherInfo.normalDailyMeanTemp = normalMeanTemp
                weatherInfo.normalDailyHighTemp = normalHighTemp
                weatherInfo.dailyDeviationTemp = deviationTemp
                weatherInfo.normalMonthlyLowTemp = sumMinTemp / Double(counterMin)
                weatherInfo.normalMonthlyHighTemp = sumMaxTemp / Double(counterMax)
                ///
                /// Oppdaterer weatherInfo med nedbørsmengdene
                ///
                weatherInfo.precipitationLast30Days = precificationLast30Days
                weatherInfo.precipitationNormalLast30Days = precificationNormalLast30Days
                weatherInfo.normalDeviationPrecipitation  = Int(round(precificationLast30Days) - round(precificationNormalLast30Days))
                
                ///
                /// Finne temperaturdata for i dag FindDataFromMenu() og hourForecast!.forEach
                ///  DayDetailChart()
                ///
                
                todayFrom = GetLocalDate(date: Date()).setTime(hour: 0, min: 0, sec: 0)!
                todayTo = GetLocalDate(date: Date()).setTime(hour: 23, min: 59, sec: 0)!
                ///
                /// Må initialisere n:
                ///
                var n: AverageTemperature = AverageTemperature(type: "", hour: 0, value: 0.00)
                toDayAverageTemperatureArray.removeAll()
                
                var hour: Int = 0
                var maxValue: Double = 0.00
                var maxIndex: Int = 0
                hour = 0
                maxValue = -273.15
                maxIndex = 0
                
                hourForecast!.forEach  {
                    if $0.date >= todayFrom,
                       $0.date < todayTo {
                        n.type = String(localized: "Temperature")
                        n.hour = hour
                        ///
                        /// Finn index og verdi til største temperature.value
                        ///
                        if $0.temperature.value > maxValue {
                            maxValue = $0.temperature.value
                            maxIndex = hour
                        }
                        hour += 1
                        n.value = $0.temperature.value
                        toDayAverageTemperatureArray.append(n)
                    }
                    
                }
                ///
                /// Oppdaterer dagens max temperatur og tilhørede Index
                ///
                weatherInfo.toDayAverageTemperatureMaxValue = maxValue
                weatherInfo.toDayAverageTemperatureMaxIndex = maxIndex
                ///
                /// Finne normal min og maks temperaturdata for i dag
                ///
                ///
                let date = FormatDateToString(date:  GetLocalDate(date: Date()), format: "-MM-dd", offsetSec: 0)
                minAverageHourArray.removeAll()
                maxAverageHourArray.removeAll()
                doubleTempertureArray.removeAll()
                ///
                /// weatherInfo.startYearblir satt av :  UserDefaults.standard.object(forKey: "Use30Years")
                ///
                let x = Int(weatherInfo.startYear)
                for year in x!...yearIntToNormal {
                    (errorMessage, averageHourlyDataRecord) =
                    await GetAverageHourWeather(year: year,
                                                date: date,
                                                lat: weatherInfo.latitude ?? 0.00,
                                                lon: weatherInfo.longitude ?? 0.00)
                    var row = [Double]()
                    let count = averageHourlyDataRecord.temperature2M.count
                    for i in 0..<count {
                        row.append(averageHourlyDataRecord.temperature2M[i])
                    }
                    doubleTempertureArray.append(row)
                }
                let count = doubleTempertureArray.count
                let count1 = averageHourlyDataRecord.temperature2M.count
                var array: [Double] = []
                for i in 0..<count1 {
                    array.removeAll()
                    for j in 0..<count {
                        array.append(doubleTempertureArray[j][i])
                    }
                    minAverageHourArray.append(array.min()!)
                    maxAverageHourArray.append(array.max()!)
                }
                ///
                /// Oppdaterer dagens min og max temperatur verdier
                ///
                weatherInfo.minAverageHourArray = minAverageHourArray
                weatherInfo.maxAverageHourArray = maxAverageHourArray
                toDayAverageMinTemperatureArray.removeAll()
                hour = 0
                weatherInfo.minAverageHourArray.forEach  {
                    n.type = String(localized: "Min temperature")
                    n.hour = hour
                    n.value = $0
                    hour += 1
                    toDayAverageTemperatureArray.append(n)
                }
                toDayAverageMaxTemperatureArray.removeAll()
                hour = 0
                weatherInfo.maxAverageHourArray.forEach  {
                    n.type = String(localized: "Max temperature")
                    n.hour = hour
                    n.value = $0
                    hour += 1
                    toDayAverageTemperatureArray.append(n)
                }
                ///
                /// Oppdaterer dagens temperaturer og normale mon og max temperaturer
                ///
                weatherInfo.toDayAverageTemperatureArray = toDayAverageTemperatureArray
                
                ///
                /// Finner dagens temperaturer
                ///
                var tempTodayArray: [Double] = []
                tempTodayArray.removeAll()
                hourForecast!.forEach  {
                    if $0.date >= todayFrom,
                       $0.date < todayTo {
                        tempTodayArray.append($0.temperature.value)
                    }
                }
                ///
                /// Oppretter TemperaturMinMax med min, dagens og max temperatur
                ///
                var t: TemperaturMinMax = TemperaturMinMax(id: UUID(),
                                                           min: 0.00,
                                                           max: 0.00,
                                                           temp: 0.00,
                                                           type: "",
                                                           hour: 0)
                var temperaturMinMaxArray: [TemperaturMinMax] = []
                temperaturMinMaxArray.removeAll()
                let count3 = minAverageHourArray.count
                for i in 0..<count3 {
                    t.id = UUID()
                    t.min = minAverageHourArray[i]
                    ///
                    /// Finner minste verdien av min normal temperatur
                    ///
                    if i == 0 {
                        minx = minAverageHourArray[i]
                    } else {
                        if minAverageHourArray[i] < minx {
                            minx = minAverageHourArray[i]
                        }
                    }
                    t.max = maxAverageHourArray[i]
                    ///
                    /// Finner største verdi av max normal temperatur
                    ///
                    if i == 0 {
                        maxx = maxAverageHourArray[i]
                    } else {
                        if maxAverageHourArray[i] > maxx {
                            maxx = maxAverageHourArray[i]
                        }
                    }
                    t.temp = tempTodayArray[i]
                    t.type = String(localized: "Temperature")
                    t.hour = i
                    temperaturMinMaxArray.append(t)
                }
                weatherInfo.temperaturMinMaxArray = temperaturMinMaxArray
                weatherInfo.temperaturMinMaxArrayAverageMinTemp = minx
                weatherInfo.temperaturMinMaxArrayAverageMaxTemp = maxx
                ///
                /// Finn 10 eller 30 år med nebør ut fra Setting
                ///
                var startDate: String = ""
                let use30Years = UserDefaults.standard.object(forKey: "Use30Years") as? Bool ?? false
                if use30Years == false {
                    startDate = startDate10Years
                    weatherInfo.startYear = "2011"
                    weatherInfo.averageDivisor = 10
                } else {
                    startDate = startDate30Years
                    weatherInfo.startYear = "1991"
                    weatherInfo.averageDivisor = 30
                }
                
                (errorMessage, averageDailyYearDataRecord) =
                await GetAverageDailyWeatherYears(startDate: startDate,
                                                  lat: weatherInfo.latitude ?? 0.00,
                                                  lon: weatherInfo.longitude ?? 0.00)
                
                var arr: [Double] = []
                var doublePrecipitationArray: [[Double]] = []
                var j: Int = -1
                var counterPrecipitation: Int = 0
                
                arr.removeAll()
                doublePrecipitationArray.removeAll()
                ///
                /// Finner gjennomsnitt av nedbør i 10 / 30 dagers perioden
                ///
                let counterP = averageDailyYearDataRecord.time.count
                for i in 0..<counterP {
                    for year in yearIntFromNormal10...yearIntToNormal { // yearIntToNormal {
                        if averageDailyYearDataRecord.time[i] >=  String(year) + fromDate,
                           averageDailyYearDataRecord.time[i] <= String(year) + toDate {
                            j += 1
                            arr.append(averageDailyYearDataRecord.precipitationSum[i])
                            if j == 29 {
                                counterPrecipitation += 1
                                ///
                                /// Oppdatere the double  array
                                ///
                                doublePrecipitationArray.append(arr)
                                arr.removeAll()
                                j = -1
                            }
                        }
                    }
                }
                ///
                /// Oppdaterer et 30 dagers normal nedbør array
                ///
                func FindAverageDoubleArray(index: Int, divisor: Int, doubleArray: [[Double]]) -> Int {
                    var average: Int = 0
                    var value: Double = 0.00
                    var sumValue: Double = 0.00
                    for i in 0..<counterPrecipitation {
                        value = doublePrecipitationArray[i][index]
                        sumValue += value
                    }
                    average = Int(round(sumValue / Double(divisor)))
                    return average
                }
                
                averagePrecipitationOverYears.removeAll()
                
                var array1: [Int] = []
                array1.removeAll()
                var array2: [Int] = []
                array2.removeAll()
                
                for index in 0...29 {
                    array1.append(FindAverageDoubleArray(index: index,
                                                         divisor: weatherInfo.averageDivisor,
                                                         doubleArray: doublePrecipitationArray))
                }
                var value: Int = 0
                ///
                /// Oppdaterer array2
                ///
                for i in 0...29 {
                    if i == 0 {
                        value = array1[i]
                        array2.append(value)
                    } else {
                        value += array1[i]
                        array2.append(value)
                    }
                }
                ///
                /// Tilpasser averagePrecipitationOverYears til Chart
                ///
                
                var v = PrecipitationOverYears(id: UUID(),
                                               precipitation: 0.00,
                                               type: "",
                                               index: 0,
                                               date: "")
                averagePrecipitationOverYears.removeAll()
                
                let count4 = array1.count
                
                for i in 0..<count4 {
                    v.id = UUID()
                    v.precipitation = Double(array2[i])
                    v.type = "PrecipitationOverYears"
                    v.index = i
                    v.date = ""
                    averagePrecipitationOverYears.append(v)
                }
                
                weatherInfo.averagePrecipitationOverYears = averagePrecipitationOverYears
            }
            ///
            /// Finner normle månedlige min  og maks temperaturer
            ///
            for i in 0..<averageYearsPerDayDataRecord.time.count {
                if averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00 > 0.00 {
                    if averageYearsPerDayDataRecord.time[i].contains("-01-") {
                        averageJanuaryData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageJanuaryData.counterMin += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-02-") {
                        averageFebruaryData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageFebruaryData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-03-") {
                        averageMarsData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageMarsData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-04-") {
                        averageAprilData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageAprilData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-05-") {
                        averageMayData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageMayData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-06-") {
                        averageJuneData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageJuneData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-07-") {
                        averageJulyData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageJulyData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-08-") {
                        averageAugustData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageAugustData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-09-") {
                        averageSeptemberData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageSeptemberData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-10-") {
                        averageOctoberData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageOctoberData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-11-") {
                        averageNovemberData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageNovemberData.counterMin += 1
                    } else if  averageYearsPerDayDataRecord.time[i].contains("-12-") {
                        averageDecemberData.minTemp += averageYearsPerDayDataRecord.temperature2MMin[i] ?? 0.00
                        averageDecemberData.counterMin += 1
                    }
                }
                ///
                /// Finner maxTempertaturene
                ///
                if averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00 > 0.00 {
                    if averageYearsPerDayDataRecord.time[i].contains("-01-") {
                        averageJanuaryData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageJanuaryData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-02-") {
                        averageFebruaryData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageFebruaryData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-03-") {
                        averageMarsData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageMarsData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-04-") {
                        averageAprilData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageAprilData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-05-") {
                        averageMayData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageMayData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-06-") {
                        averageJuneData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageJuneData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-07-") {
                        averageJulyData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageJulyData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-08-") {
                        averageAugustData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageAugustData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-09-") {
                        averageSeptemberData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageSeptemberData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-10-") {
                        averageOctoberData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageOctoberData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-11-") {
                        averageNovemberData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageNovemberData.counterMax += 1
                    } else if averageYearsPerDayDataRecord.time[i].contains("-12-") {
                        averageDecemberData.maxTemp += averageYearsPerDayDataRecord.temperature2MMax[i] ?? 0.00
                        averageDecemberData.counterMax += 1
                    }
                }
                ///
                /// Finner månedlige nedbørsmengder
                ///
                if averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00 > 0.00 {
                    if averageYearsPerDayDataRecord.time[i].contains("-01-") {
                        averageJanuaryData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-02-") {
                        averageFebruaryData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-03-") {
                        averageMarsData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-04-") {
                        averageAprilData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-05-") {
                        averageMayData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-06-") {
                        averageJuneData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-07-") {
                        averageJulyData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-08-") {
                        averageAugustData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-09-") {
                        averageSeptemberData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-10-") {
                        averageOctoberData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-11-") {
                        averageNovemberData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    } else if averageYearsPerDayDataRecord.time[i].contains("-12-") {
                        averageDecemberData.precipitation += averageYearsPerDayDataRecord.precipitationSum[i] ?? 0.00
                    }
                }
            }
            ///
            /// Brukker settings for å finne riktigdovisor for nedbør i en måned (10 år eller 30 år)
            ///
            let use30Years = UserDefaults.standard.object(forKey: "Use30Years") as? Bool ?? false
            divisor = 10.00
            if use30Years == true {
                divisor = 30.00
            }
            
            weatherInfo.normalJanuaryMin = ToInteger(averageJanuaryData.minTemp, averageJanuaryData.counterMin)
            weatherInfo.normalJanuaryMax = ToInteger(averageJanuaryData.maxTemp, averageJanuaryData.counterMax)
            weatherInfo.normalJanuaryPrecipitation = ToInteger(averageJanuaryData.precipitation, divisor)
            
            weatherInfo.normalFebruaryMin = ToInteger(averageFebruaryData.minTemp, averageFebruaryData.counterMin)
            weatherInfo.normalFebruaryMax = ToInteger(averageFebruaryData.maxTemp, averageFebruaryData.counterMax)
            weatherInfo.normalFebruaryPrecipitation = ToInteger(averageFebruaryData.precipitation, divisor)
            
            weatherInfo.normalMarsMin = ToInteger(averageMarsData.minTemp, averageMarsData.counterMin)
            weatherInfo.normalMarsMax = ToInteger(averageMarsData.maxTemp, averageMarsData.counterMax)
            weatherInfo.normalMarsPrecipitation = ToInteger(averageMarsData.precipitation, divisor)
            
            weatherInfo.normalAprilMin = ToInteger(averageAprilData.minTemp, averageAprilData.counterMin)
            weatherInfo.normalAprilMax = ToInteger(averageAprilData.maxTemp, averageAprilData.counterMax)
            weatherInfo.normalAprilPrecipitation = ToInteger(averageAprilData.precipitation, divisor)
            
            weatherInfo.normalMayMin = ToInteger(averageMayData.minTemp, averageMayData.counterMin)
            weatherInfo.normalMayMax = ToInteger(averageMayData.maxTemp, averageMayData.counterMax)
            weatherInfo.normalMayPrecipitation = ToInteger(averageMayData.precipitation, divisor)
            
            weatherInfo.normalJuneMin = ToInteger(averageJuneData.minTemp, averageJuneData.counterMin)
            weatherInfo.normalJuneMax = ToInteger(averageJuneData.maxTemp, averageJuneData.counterMax)
            weatherInfo.normalJunePrecipitation = ToInteger(averageJuneData.precipitation,divisor)
            
            weatherInfo.normalJulyMin = ToInteger(averageJulyData.minTemp, averageJulyData.counterMin)
            weatherInfo.normalJulyMax = ToInteger(averageJulyData.maxTemp, averageJulyData.counterMax)
            weatherInfo.normalJulyPrecipitation = ToInteger(averageJulyData.precipitation, divisor)
            
            weatherInfo.normalAugustMin = ToInteger(averageAugustData.minTemp, averageAugustData.counterMin)
            weatherInfo.normalAugustMax = ToInteger(averageAugustData.maxTemp, averageAugustData.counterMax)
            weatherInfo.normalAugustPrecipitation = ToInteger(averageAugustData.precipitation, divisor)
            
            weatherInfo.normalSeptemberMin = ToInteger(averageSeptemberData.minTemp, averageSeptemberData.counterMin)
            weatherInfo.normalSeptemberMax = ToInteger(averageSeptemberData.maxTemp, averageSeptemberData.counterMax)
            weatherInfo.normalSeptemberPrecipitation = ToInteger(averageSeptemberData.precipitation, divisor)
            
            weatherInfo.normalOctoberMin = ToInteger(averageOctoberData.minTemp, averageOctoberData.counterMin)
            weatherInfo.normalOctoberMax = ToInteger(averageOctoberData.maxTemp, averageOctoberData.counterMax)
            weatherInfo.normalOctoberPrecipitation = ToInteger(averageOctoberData.precipitation, divisor)
            
            weatherInfo.normalNovemberMin = ToInteger(averageNovemberData.minTemp, averageNovemberData.counterMin)
            weatherInfo.normalNovemberMax = ToInteger(averageNovemberData.maxTemp, averageNovemberData.counterMax)
            weatherInfo.normalNovemberPrecipitation = ToInteger(averageNovemberData.precipitation, divisor)
            
            weatherInfo.normalDecemberMin = ToInteger(averageDecemberData.minTemp, averageDecemberData.counterMin)
            weatherInfo.normalDecemberMax = ToInteger(averageDecemberData.maxTemp, averageDecemberData.counterMax)
            weatherInfo.normalDecemberPrecipitation = ToInteger(averageDecemberData.precipitation, divisor)
            
            ///
            /// Oppdaterer array3 fra weatherInfo.normal-------rPrecipitation
            ///
            
            var array3: [Int] = []
            array3.removeAll()
            
            array3.append(weatherInfo.normalJanuaryPrecipitation)
            array3.append(weatherInfo.normalFebruaryPrecipitation)
            array3.append(weatherInfo.normalMarsPrecipitation)
            array3.append(weatherInfo.normalAprilPrecipitation)
            array3.append(weatherInfo.normalMarsPrecipitation)
            array3.append(weatherInfo.normalAprilPrecipitation)
            array3.append(weatherInfo.normalMayPrecipitation)
            array3.append(weatherInfo.normalJunePrecipitation)
            array3.append(weatherInfo.normalJulyPrecipitation)
            array3.append(weatherInfo.normalAugustPrecipitation)
            array3.append(weatherInfo.normalSeptemberPrecipitation)
            array3.append(weatherInfo.normalOctoberPrecipitation)
            array3.append(weatherInfo.normalNovemberPrecipitation)
            array3.append(weatherInfo.normalDecemberPrecipitation)
            
            ///
            /// Tilpasser averageNormalPrecipitationMonth til Chart
            ///
            var a: AverageNormalPrecipitationMonth = AverageNormalPrecipitationMonth(id: UUID(),
                                                                                     month: "",
                                                                                     min: 0,
                                                                                     max: 0,
                                                                                     value: "")
            averageNormalPrecipitationMonth.removeAll()
            
            var counter: Double = 0.00
            var value: Double = 0.00
            
            for i in 0...11 {
                a.month = monthName[i]
                a.min = 0
                a.max = array3[i]
                value = Double(array3[i]) + counter
                a.value = "\(value)"
                averageNormalPrecipitationMonth.append(a)
                counter += 0.01
            }
            ///
            /// Oppdaterer weatherInfo.averagePrecipitationNormalYears
            ///
            weatherInfo.averageNormalPrecipitationMonth = averageNormalPrecipitationMonth
            //
            //        }
        }
        ///
        /// Må legges helt på slutten for å kunne tappe hvor som helst på body
        ///
        .onTapGesture {
            isTemperature.toggle()
        }
    }
}
