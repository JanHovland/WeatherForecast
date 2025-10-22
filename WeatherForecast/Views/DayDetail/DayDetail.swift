    //
    //  DayDetail.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 02/11/2022.
    //

import SwiftUI
import WeatherKit

struct DayDetail: View {
    
    let weather : Weather
    @Binding var dateSelected : String
    @Binding var dayDetailHide : Bool
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
        ///
        /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode
        ///  Her finnes det  bruk av @Environment(\.colorScheme) var colorScheme
        ///
        ///
        /// https://developer.apple.com/forums/thread/680109
        /// For å kunne benytte dateArry[index] må hele dateArray initialiseres.
        /// Er det aktuelt med antall lik 10 må dateArray initialiseres med 10 verdier.
        ///
    
    @State var dateSettings: DateSettings
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var dateArray : [String] = Array(repeating: "", count: sizeArray10)
    @State private var dateDateArray: [Date] = Array(repeating: Date(), count: sizeArray10)
    @State private var weekdayArray : [String] = Array(repeating: "", count: sizeArray10)
    @State private var colorsBackground : [Color] = Array(repeating: Color(.systemBackground), count: sizeArray10)
    @State private var colorsBackgroundStandard: [Color] = Array(repeating: Color(.systemBackground), count: sizeArray10)
    @State private var arrayDayIcons : [String] = Array(repeating: String(), count: sizeArray12)
    
    @State private var hourIconArray : [String] = Array(repeating: String(), count: sizeArray12)
    
        ///
        /// Her kan man ikke benytte Color(.primary), men må benytte Color(.white).
        /// noe som skyldes at 'CGColor' has no member 'primary'
        ///
        /// Vær oppmerksom på at i light mode vises ikke .white på hvit bakgrunn,
        ///
    @State private var colorsForeground : [Color] = [Color(.systemMint),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white),
                                                     Color(.white)]
    
        ///
        /// Her kan man ikke benytte Color(.primary), men må benytte Color(.white).
        /// noe som skyldes at 'CGColor' has no member 'primary'
        ///
    @State private var colorsForegroundStandard : [Color] = [Color(.systemMint),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white),
                                                             Color(.white)]
    
    @State private var option: EnumType = .temperature
    @State private var option1: EnumType = .number12
    
    @State private var selectedValue: SelectedValue = SelectedValue()
    
    @State private var dayArray: [Double] = Array(repeating: Double(), count: sizeArray10)
    @State private var rainFalls: [RainFall] = []
    @State private var windInfo: [WindInfo] = []
    @State private var tempInfo: [Temperature] = []
    @State private var gustInfo: [Double] = []
    @State private var weatherIcon: [WeatherIcon] = []
    @State private var feltTempArray: [FeltTemp] = []
    
    @State private var index : Int = 0
    
    @State private var uvIndexArray: [String] = Array(repeating: String(), count: sizeArray12)
    @State private var windArray: [String] = Array(repeating: String(), count: sizeArray12)
    @State private var humidityArray: [String] = Array(repeating: String(), count: sizeArray12)
    @State private var visabilityArray:[String] = Array(repeating: String(), count: sizeArray12)
    @State private var airpressureArray:[String] = Array(repeating: String(), count: sizeArray12)
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    
    @State private var opacity: Double = 1.00
    
    @State private var dewPointArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var menuIcon: String
    @State private var menuTitle: String
    
    init(weather: Weather,
         dateSelected: Binding<String>,
         dayDetailHide: Binding<Bool>,
         sunRises: Binding<[String]>,
         sunSets: Binding<[String]>,
         dateSettings: DateSettings,
         menuIcon: String = "",
         menuTitle: String = "") {
        self.weather = weather
        self._dateSelected = dateSelected
        self._dayDetailHide = dayDetailHide
        self._sunRises = sunRises
        self._sunSets = sunSets
        self._dateSettings = State(initialValue: dateSettings)
        self._menuIcon = State(initialValue: menuIcon)
        self._menuTitle = State(initialValue: menuTitle)
    }
    
    var body: some View {
        
        VStack (alignment: .leading) {
                ///
                /// Viser menyvalget og knapp for avslutning:
                ///
            VStack {
                HStack {
                    HStack (alignment: .center) {
                        Spacer()
                        Image(systemName: FindMenySystemImage(menuTitle: menuTitle))
                            .font(.body)
                            .symbolRenderingMode(.multicolor)
                        Text(menuTitle)
                            .font(.title2.weight(.bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .overlay (
                        HStack {
                            Spacer()
                            Button {
                                    ///
                                    /// Rutine for å avslutte DayDetail():
                                    ///
                                Task.init {
                                    dismiss()
                                }
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30, weight: .regular))
                                    .foregroundColor(Color(.systemGray3))
                                    .padding(30)
                                    .offset(x: 20)
                            }
                        }
                    )
                }
            }
            .padding(.top, 30)
                ///
                /// Viser ukedag og dato:
                ///
            ScrollView (showsIndicators: false) {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 50) {
                            ForEach(Array(dateArray.enumerated()), id: \.element) { idx, element in
                                VStack {
                                    Text(weekdayArray[idx])
                                        .font(.system(size: 17, weight: .bold))
                                    Text(element.description)
                                        .padding(8)
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(colorsForeground[idx])
                                        .background(colorsBackground[idx])
                                        .clipShape(Circle())
                                        .onTapGesture {
                                                ///
                                                /// Resetter og oppdater forgrunnen for aktuell indeks:
                                                ///
                                            colorsForeground = updateForegroundColors(index: idx,
                                                                                      colorsForegroundStandard: colorsForegroundStandard,
                                                                                      foregroundColor: Color(.black),
                                                                                      foregroundColorIndex1: Color(.black))
                                                ///
                                                /// Resetter og oppdater bakgrunnen for aktuell indeks:
                                                ///
                                            colorsBackground = updateBackgroundColors(index: idx,
                                                                                      colorsBackgroundStandard: colorsBackgroundStandard,
                                                                                      backGroundColor: .primary,
                                                                                      backgroundColorIndex1: Color(.systemMint))
                                                ///
                                                /// Tar vare på index:
                                                ///
                                            index = idx
                                                ///
                                                /// Finner dagens høyeste og laveste temperatur:
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
                                                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetail .onTapGesture ",
                                                                                                weather: weather,
                                                                                                date: dateSettings.dates[index],
                                                                                                option: MenuTitleToOption(menuTitle: menuTitle),
                                                                                                option1: option1)
                                            arrayDayIcons = value.1
                                            hourIconArray = value.2
                                            windInfo = value.4
                                            tempInfo = value.5
                                            gustInfo = value.6
                                            weatherIcon = value.7
                                            feltTempArray = value.9
                                        }
                                }
                            }
                        }
                    } // ScrollView
                    VStack (alignment: .center) {
                            ///
                            /// Viser riktig dato,  meny og kort værinformasjon:
                            ///
                        HStack {
                            HStack (alignment: .center) {
                                Spacer()
                                Text(GetTimeFromDay(date: currentWeather.date.adding(days: index), format: "EEEE d. MMMM yyyy").firstUppercased)
                                Spacer()
                            }
                            .padding(.top, 30)
                            .overlay(
                                HStack {
                                    Spacer()
                                    DayDetailMenuDataView(weather: weather,
                                                          index: $index,
                                                          menuIcon: $menuIcon,
                                                          menuTitle: $menuTitle,
                                                          arrayDayIcons: $arrayDayIcons,
                                                          opacity: $opacity)
                                }
                            )
                        }
                            ///
                            /// Viser natt og dag:
                            ///
                        SunDayAndNight(xMax:
                                        UIDevice.isIpad ? 500 : 300,
                                       index : index,
                                       sunRises: $sunRises,
                                       sunSets: $sunSets)
                            ///
                            /// Viser meny og kort værinformasjon:
                            ///
                        DayDetailWeatherData(weather: weather,
                                             menuTitle: $menuTitle,
                                             index: $index,
                                             arrayDayIcons: $arrayDayIcons)
                        .opacity(opacity == 1.00 ? 1.00 : 0.00)
                            ///
                            /// Viser image rekken:
                            ///
                            //                            DayDetailIcons(option: MenuTitleToOption(menuTitle: menuTitle),
                            //                                           index: index,
                            //                                           weather: weather,
                            //                                           hourIconArray: $hourIconArray,
                            //                                           width: 300)
                            //                            .modifier(DayDetailHourIconsModifier(menuTitle: $menuTitle))
                            ///
                            /// Viser data for aktuell option:
                            ///
                        DayDetailDayDataView(weather: weather,
                                             option: MenuTitleToOption(menuTitle: menuTitle),
                                             arrayDayIcons: $arrayDayIcons,
                                             dateArray: $dateSettings.dates,
                                             index: $index,
                                             colorsForeground: $colorsForeground,
                                             colorsForegroundStandard: $colorsForegroundStandard,
                                             colorsBackground: $colorsBackground,
                                             colorsBackgroundStandard: $colorsBackgroundStandard,
                                             dayDetailHide: $dayDetailHide,
                                             selectedValue: $selectedValue,
                                             dayArray: $dayArray,
                                             rainFalls: $rainFalls,
                                             weekdayArray: $weekdayArray,
                                             windInfo: $windInfo,
                                             tempInfo: $tempInfo,
                                             gustInfo: $gustInfo,
                                             feltTempArray: $feltTempArray,
                                             opacity: $opacity,
                                             dewPointArray: $dewPointArray)
                        
                        .modifier(DayDetailOffsetChartViewModifier(option: MenuTitleToOption(menuTitle: menuTitle)))
                            ///
                            /// Viser utvidet informasjon om været:
                            ///
                        DayDetailInfo(weather: weather,
                                      option: MenuTitleToOption(menuTitle: menuTitle),
                                      index: $index,
                                      dayArray: $dayArray,
                                      weekdayArray: $weekdayArray,
                                      windInfo: $windInfo,
                                      tempInfo: $tempInfo,
                                      weatherIcon: $weatherIcon)
                        .modifier(DayDetailOffsetInfoViewModifier(option: MenuTitleToOption(menuTitle: menuTitle)))
                    }
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: 3000)
            .padding()
            Spacer()
                .onChange(of: index) { oldIndex, index in
                        ///
                        /// Finner menuIcon
                        ///
                    menuIcon = FindMenySystemImage(menuTitle: menuTitle)
                        ///
                        /// Oppdaterer weatherIcon:
                        ///
                    let value: ([Double],
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
                                [NewPrecipitation]) =  FindDataFromMenu(info: "DayDetail change index",
                                                                        weather: weather,
                                                                        date: dateSettings.dates[index],
                                                                        option: MenuTitleToOption(menuTitle: menuTitle),
                                                                        option1: option1)
                    hourIconArray = value.2
                    windInfo = value.4
                    tempInfo = value.5
                    
                }
                .onChange(of: MenuTitleToOption(menuTitle: menuTitle)) { oldOption, option in
                        ///
                        /// Finner menuIcon
                        ///
                    menuIcon = FindMenySystemImage(menuTitle: menuTitle)
                        ///
                        /// Oppdaterer weatherIcon:
                        ///
                    let value: ([Double],
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
                                [NewPrecipitation]) =  FindDataFromMenu(info: "DayDetail change option",
                                                                        weather: weather,
                                                                        date: dateSettings.dates[index],
                                                                        option: MenuTitleToOption(menuTitle: menuTitle),
                                                                        option1: option1)
                    hourIconArray = value.2
                    windInfo = value.4
                    tempInfo = value.5
                }
                .task {
                        ///
                        /// Finner menuIcon
                        ///
                    menuIcon = FindMenySystemImage(menuTitle: menuTitle)
                    
                    let value: ([Double],
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
                                [NewPrecipitation]) =  FindDataFromMenu(info: "DayDetail change option",
                                                                        weather: weather,
                                                                        date: dateSettings.dates[index],
                                                                        option: MenuTitleToOption(menuTitle: menuTitle),
                                                                        option1: option1)
                    hourIconArray = value.2
                    windInfo = value.4
                    tempInfo = value.5
                        /// Resetter selectedValue fra gesture i DayDetailChart():
                        ///
                    selectedValue.icon  = ""
                    selectedValue.value1  = ""
                    selectedValue.value2  = ""
                        ///
                        /// Oppretter dateArray ut fra weather:
                        ///
                    
                    let value2: ([String], [Date], [String])
                    value2 = createDateArray(format: UIDevice.isIpad ? "E" : "EEEEEE", offsetSec: weatherInfo.offsetSec)
                    dateArray = value2.0
                    dateDateArray = value2.1
                    weekdayArray = value2.2
                        ///
                        /// Sletter innholdet i dateSetting.dates:
                        ///
                    dateSettings.dates.removeAll()
                    dateSettings.index = 0
                        ///
                        /// Oppdaterer dateSetting.dates:
                        ///
                    var date: Date = Date().setTime(hour: 0, min: 0, sec: 0) ?? Date()
                    
                    for i in 0..<10 {
                        date = DateAddDay(day: i).setTime(hour: 0, min: 0, sec: 0)!
                        dateSettings.index = i
                        dateSettings.dates.append(date)
                    }
                    
                    if dateArray.contains(dateSelected) {
                            ///
                            /// Finn valgt index i dateArray:
                            ///
                        dateSettings.index = dateArray.firstIndex(of: dateSelected)!
                        index = dateSettings.index
                        
                    } else {
                            ///
                            /// Ser ut som det er tilfeldig om dateArray.contains(dateSelected) er false
                            /// Velger derfor å kommentere bort :showAlert.toggle()
                            ///
                            ///
                            /// Gir feilmelding dersom dateSelected ikke finnes i dateArray:
                            ///
                        title = "'dateSelected' value == \(dateSelected)"
                        message = "Value == \(dateSelected) is not part of the 'dateArray'."
                        showAlert.toggle()
                    }
                    if weekdayArray.count < 10 {
                        title = "Number of elements in 'weekdayArray'"
                        message = "Number of elements in 'weekdayArray' should be 10"
                        showAlert.toggle()
                    }
                        ///
                        /// Resetter colors og oppdater forgrunnen for index = 0:
                        ///
                    colorsForeground = updateForegroundColors(index: dateSettings.index,
                                                              colorsForegroundStandard: colorsForegroundStandard,
                                                              foregroundColor: Color(.black),
                                                              foregroundColorIndex1: Color(.black))
                        ///
                        /// Resetter colors og oppdater bakgrunnen for index = 0:
                        ///
                    colorsBackground = updateBackgroundColors(index: dateSettings.index,
                                                              colorsBackgroundStandard: colorsBackgroundStandard,
                                                              backGroundColor: .primary,
                                                              backgroundColorIndex1: Color(.systemMint))
                }
                .alert(title, isPresented: $showAlert) {
                }
            message: {
                Text(message)
            }
        }
    }
}
