//
//  DayDetailChart.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 09/11/2022.
//

import SwiftUI
import WeatherKit
import Charts

///
/// https://swdevnotes.com/swift/2022/customise-a-line-chart-with-swiftui-charts-in-ios-16/
/// https://blckbirds.com/post/charts-in-swiftui-part-1-bar-chart/
/// https://swdevnotes.com/swift/2022/customise-a-line-chart-with-swiftui-charts-in-ios-16/
/// https://trailingclosure.com/recreating-the-strava-activity-graph/
/// https://stackoverflow.com/questions/74893856/swiftui-charts-how-to-put-an-annotation-at-the-top-of-a-chart-and-have-a-line
/// https://stackoverflow.com/questions/74100355/barmark-drawing-on-top-of-y-axis
/// https://swiftuirecipes.com/companion
/// https://medium.com/devtechie/align-charts-mark-style-with-chart-plot-area-in-swiftui-4-and-charts-framework-9bf91163ede5
///

struct DayDetailChart: View {
    
    @Binding var rainFalls: [RainFall]
    @Binding var dayArray: [Double]
    @Binding var dayDetailHide: Bool
    var option: EnumType
    @Binding var dateArray: [Date]
    @Binding var index : Int
    @Binding var selectedValue : SelectedValue
    @Binding var weekdayArray : [String]
    @Binding var windInfo: [WindInfo]
    @Binding var tempInfo: [Temperature]
    @Binding var gustInfo: [Double]
    @Binding var weatherIcon: [WeatherIcon]
    let weather: Weather
    @Binding var feltTempArray: [FeltTemp]
    @Binding var opacity: Double
    @Binding var dewPointArray: [Double]
    @Binding var colorsForeground : [Color]
    @Binding var colorsForegroundStandard : [Color]
    @Binding var colorsBackground : [Color]
    @Binding var colorsBackgroundStandard : [Color]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var frameindexPointMarkWidth: CGFloat = 0.00
    @State private var frameWidth: CGFloat = 0.00
    @State private var frameHeight: CGFloat = 0.00
    @State private var leading: CGFloat = 0.00
    @State private var show : Bool = false
    @State private var hourIconArray : [String] = Array(repeating: String(), count: sizeArray24)
    @State private var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    ///
    /// Temperatur:
    ///
    @State private var tempMin: Double = 0.00
    @State private var tempMax: Double = 0.00
    @State private var tempMinIndex: Int = 0
    @State private var tempMaxIndex: Int = 0
    ///
    /// Vind:
    ///
    @State private var windMin: Double = 0.00
    @State private var windMax: Double = 0.00
    @State private var windMinIndex: Int = 0
    @State private var windMaxIndex: Int = 0
    ///
    /// Vindkast::
    ///
    @State private var windGustMin: Double = 0.00
    @State private var windGustMax: Double = 0.00
    @State private var windGustMinIndex: Int = 0
    @State private var windGustMaxIndex: Int = 0
    ///
    /// Føles som:
    ///
    @State private var feelslikeMin: Double = 0.00
    @State private var feelslikeMax: Double = 0.00
    @State private var feelslikeMinIndex: Int = 0
    @State private var feelslikeMaxIndex: Int = 0
    ///
    /// Nedbør
    ///
    @State private var precipitationMax: Double = 0.00
    @State private var precipitationMinIndex: Int = 0
    @State private var precipitationMaxIndex: Int = 0
    
    ///
    /// UvIndex:
    ///
    @State private var uvIndexMin: Double = 0.00
    @State private var uvIndexMax : Double = 0.00
    @State private var uvIndexMinIndex: Int = 0
    @State private var uvIndexMaxIndex: Int = 0
    ///
    /// Sikt:
    ///
    @State private var visibilityMin: Double = 0.00
    @State private var visibilityMax : Double = 0.00
    @State private var visibilityMinIndex: Int = 0
    @State private var visibilityMaxIndex: Int = 0
    ///
    /// Lufttrykk::
    ///
    @State private var airPressureMin: Double = 0.00
    @State private var airPressureMax : Double = 0.00
    @State private var airPressureMinIndex: Int = 0
    @State private var airPressureMaxIndex: Int = 0
    ///
    /// Luftfuktighet:
    ///
    @State private var humidityMin: Double = 0.00
    @State private var humidityMax: Double = 0.00
    @State private var humidityMinIndex: Int = 0
    @State private var humidityMaxIndex: Int = 0
    ///
    /// Precification:
    ///
    @State private var precificationMin: Double = 0.00
    @State private var precificationMax: Double = 0.00
    @State private var precificationMinIndex: Int = 0
    @State private var precificationMaxIndex: Int = 0
    
    @State private var selectedIndex: Int?
    
    @State private var rangeFrom: Int = 0
    @State private var rangeTo: Int = 0
    
    @State private var selectedAmount: Double = 0.00
    
    @State private var newTemperature: [NewTemperature] = []
    @State private var newUvIndex: [NewUvIndex] = []
    @State private var newWind: [NewWind] = []
    @State private var newFeelsLike: [NewFeelsLike] = []
    @State private var newHumidity: [NewHumidity] = []
    @State private var newVisibility: [NewVisibility] = []
    @State private var newAirPressure: [NewAirPressure] = []
    @State private var newPrecification: [NewPrecipitation] = []

    let rangeTempMinValue =  9
    let rangeTempMaxValue =  9
    let rangeGustValue = 15
    let rangeVisibilityValue = 10
    let rangeAirPressureMaxValue = 10
    let rangeAirPressureMinValue = 100
    let rangeHumidityMaxValue = 10
    let rangeHumidityMinValue = 10

    var body: some View {
        VStack (alignment: .center) {
            ///
            /// Viser de forskjellige Chart:
            ///
            VStack {
                Chart {
                    if option == .precipitation {
                        ForEach(newPrecification) {
                            BarMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", "\($0.type)"))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                    } else if option == .wind {
                        ForEach(newWind) {
                            if $0.type == "Vind" {
                                AreaMark(
                                    x: .value("Hour", $0.hour),
                                    y: .value("Value", $0.value)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(by: .value("Type", $0.type))
                                .opacity(0.25)
                            }
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", "\($0.type)"))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: -10) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        PointMark(x: .value("Hour", windMinIndex),
                                  y: .value("Value", windMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if windMin > 0.00 {
                                Text("L")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        PointMark(x: .value("Hour", windMaxIndex),
                                  y: .value("Value", windMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if windMax > 0.00 {
                                Text("H")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                    } else if option == .temperature {
                        ForEach(newTemperature) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", "\($0.type)"))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Value", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: UIDevice.isIpad ? -20 : -20) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        /// Markerer laveste temperatur
                        ///
                        PointMark(x: .value("Hour", tempMinIndex),
                                  y: .value("Value", tempMin))
                        .annotation(position: .top) {
                            Text("L")
                                .font(.footnote.weight(.bold))
                        }
                        ///
                        /// Markerer høyeste temperatur
                        ///
                        PointMark(x: .value("Hour", tempMaxIndex),
                                  y: .value("Value",tempMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            Text("H")
                                .font(.footnote.weight(.bold))
                        }
                    } else if option == .feelsLike {
                        ForEach(newFeelsLike) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", "\($0.type)"))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: UIDevice.isIpad ? -10 : 20) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        PointMark(x: .value("Hour", feelslikeMinIndex),
                                  y: .value("Value", feelslikeMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            Text("L")
                                .font(.footnote.weight(.bold))
                                .opacity(0.50)
                        }
                        PointMark(x: .value("Hour", feelslikeMaxIndex),
                                  y: .value("Value", feelslikeMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            Text("H")
                                .font(.footnote.weight(.bold))
                                .opacity(0.50)
                        }
                    } else if option == .uvIndex {
                        ForEach(newUvIndex) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", "\($0.type)"))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: 0) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        PointMark(x: .value("Hour", uvIndexMinIndex),
                                  y: .value("Value", uvIndexMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if uvIndexMin > 0.00  {
                                Text("L")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        PointMark(x: .value("Hour", uvIndexMaxIndex),
                                  y: .value("Value", uvIndexMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if uvIndexMax > 0.00 {
                                Text("H")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        
                    } else if option == .visibility {
                        let description = String(localized: "Visibility")
                        ForEach(newVisibility) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", description))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: UIDevice.isIpad ? -20 : -10) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        PointMark(x: .value("Hour", visibilityMinIndex),
                                  y: .value("Value", visibilityMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if visibilityMin > 0.00 {
                                Text("L")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        PointMark(x: .value("Hour", visibilityMaxIndex),
                                  y: .value("Value", visibilityMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if visibilityMax > 0.00 {
                                Text("H")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                    } else if option == .airPressure {
                        let description = String(localized: "Airpressure")
                        ForEach(newAirPressure) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", description))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: UIDevice.isIpad ? -35 : -40) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        ///
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        PointMark(x: .value("Hour", airPressureMinIndex),
                                  y: .value("Value", airPressureMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if airPressureMin > 0.00 {
                                Text("L")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        PointMark(x: .value("Hour", airPressureMaxIndex),
                                  y: .value("Value", airPressureMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if airPressureMax > 0.00 {
                                Text("H")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                    } else if option == .humidity  {
                        let description = String(localized: "Humidity")
                        ForEach(newHumidity) {
                            LineMark (
                                x: .value("Hour", $0.hour),
                                y: .value("Value", $0.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(by: .value("Type", description))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                        }
                        ///
                        ///
                        /// Markerer minste "L" og høyeste "H"
                        ///
                        if let selectedIndex {
                            RuleMark(x: .value("Hour", selectedIndex))
                                .annotation(
                                    position: .top, spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )
                                ) {
                                    showSelectedValue
                                }
                                .foregroundStyle(Color.white.opacity(0.15))
                                .offset(yStart: UIDevice.isIpad ? -10 : -10) /// Viser verdien relativt til største verdi av "Value"
                                .zIndex(-1)
                        }
                        PointMark(x: .value("Hour", humidityMinIndex),
                                  y: .value("Value", humidityMin))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if humidityMin > 0.00 {
                                Text("L")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                        PointMark(x: .value("Hour", humidityMaxIndex),
                                  y: .value("Value", humidityMax))
                        .symbol(.circle)
                        .annotation(position: .top) {
                            if humidityMax > 0.00 {
                                Text("H")
                                    .font(.footnote.weight(.bold))
                                    .opacity(0.50)
                            }
                        }
                    }
                    ///
                    /// Markerer den tidligere delen av dagen:
                    ///
                    RectangleMark (xStart: .value("Range Start", 0),
                                   xEnd: .value("Range End", index == 0 ? currentWeather.hour : 0)
                    )
                    .foregroundStyle(.black.opacity(0.35))
                }
                .frame(maxWidth: .infinity,
                       minHeight: 200,
                       maxHeight: 250)
                .padding()
                .chartXScale(domain: 0...23)
                ///
                /// Endrer y aksen for:
                ///     . uvIndex,
                ///     . airPressure,
                ///
                .modifier(DayDetailChartYaxis(option: option, from: rangeFrom, to: rangeTo))
                .chartYAxisLabel(ShowUnit(option: option),
                                 position: .top,
                                 spacing: 3)  /// avstand mellom rangeTo og betegnelsen (m/s o.l.)
                .chartXSelection(value: $selectedIndex)
                .offset(y: UIDevice.isIpad ? 10 : 10)
            }
            ///
            /// Her er en gesture som ligger på VStack og ikke på ChartView:
            /// Denne endrer index :
            ///
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.location.x > value.startLocation.x {
                            index = index + 1
                            if index > 9 {
                                index = 9
                            }
                        } else if value.location.x < value.startLocation.x {
                            index = index - 1
                            if index < 0 {
                                index = 0
                            }
                        } else {
                            index = index
                        }
                        colorsForeground = updateForegroundColors(index: index,
                                                                  colorsForegroundStandard: colorsForegroundStandard,
                                                                  foregroundColor: Color(.black),
                                                                  foregroundColorIndex1: Color(.black))
                        ///
                        /// Resetter og oppdater bakgrunnen for aktuell indeks:
                        ///
                        colorsBackground = updateBackgroundColors(index: index,
                                                                  colorsBackgroundStandard: colorsBackgroundStandard,
                                                                  backGroundColor: .primary,
                                                                  backgroundColorIndex1: Color(.systemMint))
                    }
            )
            ///
            /// offset er forskjellig for .humidity og de andre option:
            ///
            .modifier(DayDetailChartOffsetViewModifier(option: option))
            Spacer()
        }
        .task {
            ///
            /// Resetter selectedValue fra gesture i DayDetailChart():
            ///
            selectedValue.icon = ""
            selectedValue.value1 = ""
            selectedValue.value2 = ""
            selectedValue.value3 = ""
            selectedValue.time = ""
            /// Oppdaterer bredde og høyde avhengig av on iPhone eller iPad:
            ///
            if UIDevice.isIpad {
                frameWidth = 540 // 500
                frameHeight = 150
                leading = 60
            } else {
                frameWidth = 350
                frameHeight = 200
                leading = 40
            }
            ///
            /// Her kan det kun komme option ==  .temperature og index == 0:
            ///
            let value : ([Double],
                         [String],
                         [String],
                         [RainFall],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailChart.task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: option,
                                                                option1: .number24)
            hourIconArray = value.2
            ///
            /// ** tempInfo må være med !
            ///
            tempInfo = value.5
            windInfo = value.4

            if option == .temperature {
                let val3 : ([NewTemperature],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataTemperature(weather: weather,
                                                            date: dateSettings.dates[index],
                                                            option: .temperature)
                newTemperature = val3.0
                tempMin = val3.1
                tempMax = val3.2
                tempMinIndex = val3.3
                tempMaxIndex = val3.4
                rangeFrom = val3.5
                rangeTo = val3.6
                
                ///
                /// Av en eller annen grunn måtte jeg legge til:
                ///     .humidity
                ///     .airPressure
                ///     .visibility
                ///     .uvIndex
                
            } else if option == .uvIndex {
                let val03 : ([NewUvIndex],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataUvIndex(weather: weather,
                                                         date: dateSettings.dates[index],
                                                         option: .uvIndex)
                newUvIndex = val03.0
                uvIndexMin = val03.1
                uvIndexMax = val03.2
                uvIndexMinIndex = val03.3
                uvIndexMaxIndex = val03.4
                rangeFrom = val03.5
                rangeTo = val03.6
            } else if option == .wind {
                let val04 : ([NewWind],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataWind(weather: weather,
                                                      date: dateSettings.dates[index],
                                                      option: .wind)
                newWind = val04.0
                windMin = val04.1
                windMax = val04.2
                windMinIndex = val04.3
                windMaxIndex = val04.4
                rangeFrom = val04.5
                rangeTo = val04.6
            } else if option == .feelsLike {
                let val05 : ([NewFeelsLike],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataFeelsLike(weather: weather,
                                                           date: dateSettings.dates[index],
                                                           option: .feelsLike)
                newFeelsLike = val05.0
                feelslikeMin = val05.1
                feelslikeMax = val05.2
                feelslikeMinIndex = val05.3
                feelslikeMaxIndex = val05.4
                rangeFrom = val05.5
                rangeTo = val05.6
            } else if option == .visibility {
                let val06 : ([NewVisibility],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataVisibility(weather: weather,
                                                            date: dateSettings.dates[index],
                                                            option: .visibility)
                newVisibility = val06.0
                visibilityMin = val06.1
                visibilityMax = val06.2
                visibilityMinIndex = val06.3
                visibilityMaxIndex = val06.4
                rangeFrom = val06.5
                rangeTo = val06.6
            } else if option == .humidity {
                let val07 : ([NewHumidity],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataHumidity(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .humidity)
                newHumidity = val07.0
                humidityMin = val07.1
                humidityMax = val07.2
                humidityMinIndex = val07.3
                humidityMaxIndex = val07.4
                rangeFrom = val07.5
                rangeTo = val07.6
            } else if option == .airPressure {
                let val08 : ([NewAirPressure],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataAirPressure(weather: weather,
                                                             date: dateSettings.dates[index],
                                                             option: .airPressure)
                newAirPressure = val08.0
                airPressureMin = val08.1
                airPressureMax = val08.2
                airPressureMinIndex = val08.3
                airPressureMaxIndex = val08.4
                rangeFrom = val08.5
                rangeTo = val08.6
            } else if option == .precipitation {
                
                let val07 : ([NewPrecipitation],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataPrecipitation(weather: weather,
                                                               date: dateSettings.dates[index],
                                                               option: .precipitation)
                newPrecification = val07.0
                precificationMin = val07.1
                precificationMax = val07.2
                precificationMinIndex = val07.3
                precificationMaxIndex = val07.4
                rangeFrom = val07.5
                rangeTo = val07.6
            }
        }
        .onChange(of: option) { oldOption, option in
            let val01 : ([Double],
                         [String],
                         [String],
                         [RainFall],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailChart change option",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: option,
                                                                option1: .number24)
            hourIconArray = val01.2
            ///
            /// ** tempInfo må være med !
            ///
            tempInfo = val01.5
            windInfo = val01.4

            if option == .temperature {
                let val02 : ([NewTemperature],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataTemperature(weather: weather,
                                                             date: dateSettings.dates[index],
                                                             option: .temperature)
                newTemperature = val02.0
                tempMin = val02.1
                tempMax = val02.2
                tempMinIndex = val02.3
                tempMaxIndex = val02.4
                rangeFrom = val02.5
                rangeTo = val02.6
            } else if option == .uvIndex {
                let val03 : ([NewUvIndex],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataUvIndex(weather: weather,
                                                         date: dateSettings.dates[index],
                                                         option: .uvIndex)
                newUvIndex = val03.0
                uvIndexMin = val03.1
                uvIndexMax = val03.2
                uvIndexMinIndex = val03.3
                uvIndexMaxIndex = val03.4
                rangeFrom = val03.5
                rangeTo = val03.6
            } else if option == .wind {
                let val04 : ([NewWind],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataWind(weather: weather,
                                                      date: dateSettings.dates[index],
                                                      option: .wind)
                newWind = val04.0
                windMin = val04.1
                windMax = val04.2
                windMinIndex = val04.3
                windMaxIndex = val04.4
                rangeFrom = val04.5
                rangeTo = val04.6
            } else if option == .feelsLike {
                let val05 : ([NewFeelsLike],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataFeelsLike(weather: weather,
                                                           date: dateSettings.dates[index],
                                                           option: .feelsLike)
                newFeelsLike = val05.0
                feelslikeMin = val05.1
                feelslikeMax = val05.2
                feelslikeMinIndex = val05.3
                feelslikeMaxIndex = val05.4
                rangeFrom = val05.5
                rangeTo = val05.6
            } else if option == .visibility {
                let val06 : ([NewVisibility],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataVisibility(weather: weather,
                                                            date: dateSettings.dates[index],
                                                            option: .visibility)
                newVisibility = val06.0
                visibilityMin = val06.1
                visibilityMax = val06.2
                visibilityMinIndex = val06.3
                visibilityMaxIndex = val06.4
                rangeFrom = val06.5
                rangeTo = val06.6
            } else if option == .humidity  {
                let val07 : ([NewHumidity],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataHumidity(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .humidity)
                newHumidity = val07.0
                humidityMin = val07.1
                humidityMax = val07.2
                humidityMinIndex = val07.3
                humidityMaxIndex = val07.4
                rangeFrom = val07.5
                rangeTo = val07.6
            } else if option == .airPressure {
                let val08 : ([NewAirPressure],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataAirPressure(weather: weather,
                                                             date: dateSettings.dates[index],
                                                             option: .airPressure)
                newAirPressure = val08.0
                airPressureMin = val08.1
                airPressureMax = val08.2
                airPressureMinIndex = val08.3
                airPressureMaxIndex = val08.4
                rangeFrom = val08.5
                rangeTo = val08.6
            } else if option == .precipitation {
                let val07 : ([NewPrecipitation],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataPrecipitation(weather: weather,
                                                               date: dateSettings.dates[index],
                                                               option: .precipitation)
                newPrecification = val07.0
                precificationMin = val07.1
                precificationMax = val07.2
                precificationMinIndex = val07.3
                precificationMaxIndex = val07.4
                rangeFrom = val07.5
                rangeTo = val07.6
            }
            
        }
        ///
        /// Må hente nye verdier ved gesture på Chart for å endre index:
        ///
        .onChange(of: index) { oldIndex, index in
            let val1 : ([Double],
                        [String],
                        [String],
                        [RainFall],
                        [WindInfo],
                        [Temperature],
                        [Double],
                        [WeatherIcon],
                        [Double],
                        [FeltTemp],
                        [Double],
                        [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailChart change index",
                                                               weather: weather,
                                                               date: dateSettings.dates[index],
                                                               option: option,
                                                               option1: .number12)
            hourIconArray = val1.2
            ///
            /// ** tempInfo må være med !
            ///
            tempInfo = val1.5
            windInfo = val1.4
            
            if option == .temperature {
                let val2 : ([NewTemperature],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataTemperature(weather: weather,
                                                            date: dateSettings.dates[index],
                                                            option: .temperature)
                newTemperature = val2.0
                tempMin = val2.1
                tempMax = val2.2
                tempMinIndex = val2.3
                tempMaxIndex = val2.4
                rangeFrom = val2.5
                rangeTo = val2.6
            } else if option == .uvIndex {
                let val3 : ([NewUvIndex],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataUvIndex(weather: weather,
                                                        date: dateSettings.dates[index],
                                                        option: .uvIndex)
                newUvIndex = val3.0
                uvIndexMin = val3.1
                uvIndexMax = val3.2
                uvIndexMinIndex = val3.3
                uvIndexMaxIndex = val3.4
                rangeFrom = val3.5
                rangeTo = val3.6
            } else if option == .wind {
                let val4: ([NewWind],
                           Double,
                           Double,
                           Int,
                           Int,
                           Int,
                           Int) = FindChartDataWind(weather: weather,
                                                    date: dateSettings.dates[index],
                                                    option: .wind)
                newWind = val4.0
                windMin = val4.1
                windMax = val4.2
                windMinIndex = val4.3
                windMaxIndex = val4.4
                rangeFrom = val4.5
                rangeTo = val4.6
            } else if option == .feelsLike {
                let val5 : ([NewFeelsLike],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataFeelsLike(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .feelsLike)
                newFeelsLike = val5.0
                feelslikeMin = val5.1
                feelslikeMax = val5.2
                feelslikeMinIndex = val5.3
                feelslikeMaxIndex = val5.4
                rangeFrom = val5.5
                rangeTo = val5.6
            } else if option == .visibility {
                let val6 : ([NewVisibility],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataVisibility(weather: weather,
                                                           date: dateSettings.dates[index],
                                                           option: .visibility)
                newVisibility = val6.0
                visibilityMin = val6.1
                visibilityMax = val6.2
                visibilityMinIndex = val6.3
                visibilityMaxIndex = val6.4
                rangeFrom = val6.5
                rangeTo = val6.6
            } else if option == .humidity {
                let val7 : ([NewHumidity],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataHumidity(weather: weather,
                                                         date: dateSettings.dates[index],
                                                         option: .humidity)
                newHumidity = val7.0
                humidityMin = val7.1
                humidityMax = val7.2
                humidityMinIndex = val7.3
                humidityMaxIndex = val7.4
                rangeFrom = val7.5
                rangeTo = val7.6
            } else if option == .airPressure {
                let val8 : ([NewAirPressure],
                            Double,
                            Double,
                            Int,
                            Int,
                            Int,
                            Int) = FindChartDataAirPressure(weather: weather,
                                                            date: dateSettings.dates[index],
                                                            option: .airPressure)
                newAirPressure = val8.0
                airPressureMin = val8.1
                airPressureMax = val8.2
                airPressureMinIndex = val8.3
                airPressureMaxIndex = val8.4
                rangeFrom = val8.5
                rangeTo = val8.6
            } else if option == .precipitation {
                let val07 : ([NewPrecipitation],
                             Double,
                             Double,
                             Int,
                             Int,
                             Int,
                             Int) = FindChartDataPrecipitation(weather: weather,
                                                               date: dateSettings.dates[index],
                                                               option: .precipitation)
                newPrecification = val07.0
                precificationMin = val07.1
                precificationMax = val07.2
                precificationMinIndex = val07.3
                precificationMaxIndex = val07.4
                rangeFrom = val07.5
                rangeTo = val07.6
            }
        }
    }
    @ViewBuilder
    var showSelectedValue: some View {
        VStack(alignment: .leading) {
            if selectedIndex! < sizeArray24 {
                if option == .temperature {
                    Text("\(newTemperature[selectedIndex!].value, specifier: "%.0f") \("º C")")
                }
                else if option == .uvIndex {
                    Text("\(newUvIndex[selectedIndex!].value, specifier: "%.0f")")
                }
                else if option == .wind {
                    Text("\(newWind[selectedIndex!].value, specifier: "%.0f") \("m/s")")
                }
                else if option == .feelsLike {
                    Text("\(newFeelsLike[selectedIndex!].value, specifier: "%.0f")")
                }
                else if option == .humidity {
                    Text("\(newHumidity[selectedIndex!].value, specifier: "%.0f") \("%")")
                }
                else if option == .visibility {
                    Text("\(newVisibility[selectedIndex!].value, specifier: "%.0f") \("km")")
                }
                else if option == .airPressure {
                    Text("\(newAirPressure[selectedIndex!].value, specifier: "%.0f") \("hPa")")
                }
            }
        }
        .fixedSize()
        .foregroundStyle(.primary)
        .padding(.horizontal, 7.5)
        .background {
            RoundedRectangle(cornerRadius: 7.5)
                .foregroundStyle(Color.blue.opacity(0.50))
        }
    }
    
}

