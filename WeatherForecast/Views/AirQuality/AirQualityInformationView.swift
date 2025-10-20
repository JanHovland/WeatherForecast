//
//  AirQualityInformationView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI

struct AirQualityInformationView: View {
    
    let image: String
    let so2: Double
    let no2: Double
    let pm10: Double
    let pm2_5: Double
    let o3: Double
    let co: Double

    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    @State private var so2Index: Int = 0
    @State private var no2Index: Int = 0
    @State private var pm10Index: Int = 0
    @State private var pm2_5Index: Int = 0
    @State private var o3Index: Int = 0
    @State private var coIndex: Int = 0
    
    @State private var showSO2: Bool = false
    @State private var contentSO2 = String(localized: "Sulphur dioxide is a toxic gas with a pungent smell. It mainly arises from the combustion and refining processes of coal, oil, and metal-containing ores, but also from transport-related emissions such as shipping.Sulphur dioxide is an irritant, and can cause respiratory diseases in humans and animals. It forms acid rain when dissolved in water, which damages vegetation, buildings and materials, and contributes to the acidification of terrestrial and aquatic ecosystems. Sulphur dioxide also forms secondary particulate matter (PM2.5) when combined with other compounds such as ammonia in the atmosphere.")
    @State private var titleSO2 = "\(aqSO2) \(SO2)"

    @State private var showNO2: Bool = false
    @State private var contentNO2 = String(localized: "Nitrogen dioxide (NO2) Nitrogen dioxide is formed through the oxidation of nitric oxide (NO) from combustion processes such as diesel engines and coal, oil, gas, wood, and waste plants.Nitrogen dioxide has an adverse effect on the respiratory systems of both humans and animals, increasing risks of stroke. Just like nitrogen monoxide, it dissolves in water vapour to create acid rain. Nitrogen dioxide contributes to the formation of ground-level ozone (O3), and forms secondary particulate matter (PM2.5) when combined with other atmospheric compounds such as ammonia.")
    @State private var titleNO2 = "\(aqNO2) \(NO2)"

    @State private var showPM : Bool = false
    @State private var contentPM  = String(localized: "Particulate matter (PM) Particulate matter consists of airborne liquid and solid particles. Primary particulate matter is emitted from a direct source, including power plants, vehicle traffic, construction sites, and indoor stoves and heaters. On the other hand, secondary particulate matter is formed as a result of chemical and physical reactions with various compounds, including sulphur dioxide (SO2), nitrogen dioxide (NO2), and ammonia (NH3). Particulate matter has been linked to cardiovascular and respiratory diseases such as asthma, bronchitis, and emphysema. The extent of health damage caused by particulate matter is determined by the size of the particles. Particles with a mass median diameter of less than 10 microns is called PM10, while particles with a mass median diameter of less than 2.5 microns is called PM2.5. PM2.5 are also called fine particles. Newer classifications can also include PM0.1, so-called ultra-fine particles. The smaller the particle, the higher the health risk, due to their ability to penetrate deep into the respiratory and circulatory systems, causing damage to the lungs, heart, and brain.")
    @State private var titlePM  = "\(aqPM) \(PM10) \(PM2_5)"

    @State private var showO3 : Bool = false
    @State private var contentO3  = String(localized: "Ozone (O3) Ground-level ozone is a pale blue gas with a pungent smell. It is mainly formed through the photochemical reactions of other pollutants such as nitrogen oxides, carbon monoxide, and volatile organic compounds from strong sunlight and UV radiation. Indoor sources stem from electric motors in household appliances including copiers and laser printers.Ozone is suspected to have carcinogenic effects. It leads to reduced lung function and respiratory diseases, with exposure linked to premature mortality. Apart from its impact on the human body, ozone also damages vegetation, contributing to a decrease in crop productivity and forest decline. Ozone accelerates the deterioration of rubbers, dyes, paints, coatings, and various textiles, and is also a major component of smog.")
    @State private var titleO3  = "\(aqO3) \(O3)"

    @State private var showCO : Bool = false
    @State private var contentCO  = String(localized: "Carbon monoxide (CO) Carbon monoxide is a colourless, odourless, and tasteless toxic gas. It is emitted directly from vehicles and combustion engines. Indoors, carbon monoxide is produced by boilers, fireplaces, ovens, cooker hoods, central vacuum systems, tobacco smoke, and propane heaters. Other sources of the gas are power plants, biomass burning, forest fires, and the wood industry.Upon entering the bloodstream, carbon monoxide inhibits the body’s ability to carry oxygen to organs and tissues. As such, extremely high concentrations can cause death. Infants, the elderly, and those with heart and respiratory diseases are particularly susceptible to carbon monoxide poisoning.")
    @State private var titleCO  = "\(aqCO)"

    @State private var showAmmonia : Bool = false
    @State private var contentAmmonia  = String(localized: "Ammonia (NH3) Ammonia is a colourless gas with a pungent odour. Its main source are agricultural processes, particularly in fertilizer production and livestock waste management. Indoor causes include cigarette smoke and cleaning solutions.            Ammonia irritates the eyes, nose, throat, and respiratory tract if inhaled in small amounts due to its corrosive nature and is poisonous in large quantities. It pollutes and contributes to the eutrophication and acidification of terrestrial and aquatic ecosystems. Furthermore, ammonia forms secondary particulate matter (PM2.5) when combined with other pollutants in the atmosphere.")
    @State private var titleAmmonia = String(localized: "Ammonia (NH3)")

    @State private var showNO : Bool = false
    @State private var contentNO  = String(localized: "Nitric oxide (NO) Nitric oxide, also called nitrogen monoxide, is a colourless, toxic gas formed through the combustion processes of coal and petroleum. Main sources include motor vehicles and thermal power plants.Nitric oxide dissolves in atmospheric water vapour to form acid that damages vegetation, buildings and materials, which contributes to the acidification of terrestrial and aquatic ecosystems. It also combines with VOCs to create ground-level ozone (O3).")
    @State private var titleNO = String(localized: "Nitric oxide (NO)")

    @State private var showVOC : Bool = false
    @State private var contentVOC  = String(localized: "Volatile organic compounds (VOC) Volatile organic compounds refer to a large group of carbon-containing substances including hydrocarbons, alcohols, aldehydes, and organic acids. Outdoor sources include emissions from incomplete combustion processes and volatile industry byproducts. VOCs are particularly concentrated indoors due to internal sources from interior products and building materials such as furniture, plastics, carpets, wallpapers, cleaning materials, lacquers, solvents, and tobacco smoke.As such, the indoor impact of VOCs has greater health implications since people spend time predominantly in buildings. While individual VOC levels tend to be moderate with no expected health effects, concentrations rise to concerning levels after construction works and renovations. Many individual VOCs have been shown to have toxic, carcinogenic, and mutagenic effects on humans. Symptoms include headaches, fatigue, loss of productivity, sleep disorders, and respiratory diseases, which altogether could be summarized as “Sick Building Syndrome”. The more reactive VOCs combine with nitrogen dioxide (NO2) to form ground-level ozone (O3), and contribute to creating secondary particulate matter (PM2.5) as well.")
    @State private var titleVOC = String(localized: "Volatile organic compounds (VOC)")

    @State private var so2AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:20"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "20:80"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "80:250"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "250:350"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾350")]
                       
    @State private var no2AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:40"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "40:70"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "70:150"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "150:200"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾200")]
                       
    @State private var pm10AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:20"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "20:50"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "50:100"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "100:200"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾200")]
                       
    @State private var pm2_5AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:10"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "10:25"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "25:50"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "50:75"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾75")]
                       
    @State private var o3AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:60"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "60:100"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "100:140"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "140:180"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾180")]
                       
    @State private var coAqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:4400"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "4400:9400"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "9400:12400"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "12400:15400"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾15400")]
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: image)
                        .symbolRenderingMode(.multicolor)
                        .font(Font.headline.weight(.regular))
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(.systemGray3))
                                .padding(30)
                       })
                    }
                }
            }
            
            Text("Detailed information on air quality")
                .padding(.top, -27.5)
                .foregroundColor(.teal)
            VStack {
                ///
                /// Viser sted og land:
                ///
                HStack {
                    Spacer()
                    Text("\(weatherInfo.placeName) \(weatherInfo.countryName)")
                        .font(.system(.title2).italic())
                    Spacer()
                }
                ///
                /// Viser  icon luftkvalitet
                ///
                HStack {
                    Spacer()
                    Image(systemName: image)
                        .symbolRenderingMode(.multicolor)
                        .font(Font.largeTitle.weight(.regular))
                    Spacer()
                }
                .padding(10)
            }
            ///
            /// Viser generell info om luftkvaliteten
            ///
            AirQualityGenerally
                .font(.system(.body).italic())
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            ScrollView {
                ///
                /// Viser  SO2:
                ///
                HStack {
                    Spacer()
                    Text("\(aqSO2) \(SO2)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                ///
                /// Viser nivået av SO2
                ///
                ForEach(so2AqLimit, id: \.index) { aq in
                    if aq.index == so2Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: so2,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: so2Index, index: aq.index))
                        .padding(.horizontal, 10)
                    }
                }
                ///
                /// Viser utvidet info om SO2
                ///
                CollapsibleView(showSection: $showSO2, title: $titleSO2, content: $contentSO2)
                ///
                /// Viser  NO2:
                ///
                HStack {
                    Spacer()
                    Text("\(aqNO2) \(NO2)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                ///
                /// Viser nivået av SO2
                ///
                ForEach(no2AqLimit, id: \.index) { aq in
                    if aq.index == no2Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: no2,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: no2Index, index: aq.index))
                        .padding(.horizontal, 10)
                    }
                }
                ///
                /// Viser utvidet info om NO2
                ///
                CollapsibleView(showSection: $showNO2, title: $titleNO2, content: $contentNO2)
                ///
                /// Viser  PM10:
                ///
                HStack {
                    Spacer()
                    Text("\(aqPM) \(PM10)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                ///
                /// Viser nivået av PM10
                ///
                ForEach(pm10AqLimit, id: \.index) { aq in
                    if aq.index == pm10Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: pm10,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: pm10Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  PM2.5:
                ///
                HStack {
                    Spacer()
                    Text("\(aqPM) \(PM2_5)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                ///
                /// Viser nivået av PM2_5
                ///
                ForEach(pm2_5AqLimit, id: \.index) { aq in
                    if aq.index == pm10Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: pm2_5,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: pm2_5Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser utvidet info om PM10 og PM2_5
                ///
                CollapsibleView(showSection: $showPM, title: $titlePM, content: $contentPM)
                ///
                /// Viser  O3:
                ///
                HStack {
                    Spacer()
                    Text("\(aqO3) \(O3)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                ///
                /// Viser nivået av O3
                ///
                ForEach(o3AqLimit, id: \.index) { aq in
                    if aq.index == o3Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: o3,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: o3Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser utvidet info om O3
                ///
                CollapsibleView(showSection: $showO3, title: $titleO3, content: $contentO3)
                ///
                /// Viser  CO:
                ///
                HStack {
                    Spacer()
                    Text("\(aqCO)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                ///
                /// Viser nivået av CO
                ///
                ForEach(coAqLimit, id: \.index) { aq in
                    if aq.index == coIndex {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: co,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: coIndex, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser utvidet info om CO
                ///
                CollapsibleView(showSection: $showCO, title: $titleCO, content: $contentCO)
                ///
                /// Ammoniakk
                ///
                HStack {
                    Spacer()
                    Text("Showing Ammonia information:")
                    Spacer()
                }
                .font(.system(.headline).italic())
                .padding(10)
                ///
                /// Viser utvidet info om Ammoniakk
                ///
                CollapsibleView(showSection: $showAmmonia, title: $titleAmmonia, content: $contentAmmonia)
                ///
                ///  NO
                ///
                HStack {
                    Spacer()
                    Text("Showing nitrogenmonoxide information:")
                    Spacer()
                }
                .font(.system(.headline).italic())
                .padding(10)
                ///
                /// Viser utvidet info om NO
                ///
                CollapsibleView(showSection: $showNO, title: $titleNO, content: $contentNO)
                ///
                /// VOC
                ///
                HStack {
                    Spacer()
                    Text("Showing Volatile organic compounds (VOC):")
                    Spacer()
                }
                .font(.system(.headline).italic())
                .padding(10)
                ///
                /// Viser utvidet info om VOC
                ///
                CollapsibleView(showSection: $showVOC, title: $titleVOC, content: $contentVOC)
                Spacer()
            }
            .offset(y : UIDevice.isIpad ? 0 : -25)
            .listStyle(.sidebar)
        }
        .padding(20)
        .scrollIndicators(.hidden)
        .task {
            ///
            /// Finner so2Index
            ///
            if currentWeather.so2 < 20.00 {
                so2Index = 1
            } else if currentWeather.so2 >  20.00,
                      currentWeather.so2 <= 80.00 {
                so2Index = 2
            } else if currentWeather.so2 >  80.00,
                      currentWeather.so2 <= 250.00 {
                so2Index = 3
            } else if currentWeather.so2 >  250.00,
                      currentWeather.so2 <= 350.00 {
                so2Index = 4          
            }
            else if currentWeather.so2 >= 350.00 {
                so2Index = 5
            }            ///
            /// Finner no2Index
            ///
            if currentWeather.no2 < 40.00 {
                no2Index = 1
            } else if currentWeather.no2 >  40.00,
                      currentWeather.no2 <= 70.00 {
                no2Index = 2
            } else if currentWeather.no2 >  70.00,
                      currentWeather.no2 <= 150.00 {
                no2Index = 3
            } else if currentWeather.no2 >  150.00,
                      currentWeather.no2 <= 200.00 {
                no2Index = 4
            }
            else if currentWeather.no2 >= 200.00 {
                no2Index = 5
            }
            /// Finner pm10Index
            ///
            if currentWeather.pm10 < 20.00 {
                pm10Index = 1
            } else if currentWeather.pm10 >  20.00,
                      currentWeather.pm10 <= 50.00 {
                pm10Index = 2
            } else if currentWeather.pm10 >  50.00,
                      currentWeather.pm10 <= 100.00 {
                pm10Index = 3
            } else if currentWeather.pm10 >  100.00,
                      currentWeather.pm10 <= 200.00 {
                pm10Index = 4
            }
            else if currentWeather.pm10 >= 200.00 {
                pm10Index = 5
            }
            /// Finner pm2_5Index
            ///
            if currentWeather.pm2_5 < 10.00 {
                pm2_5Index = 1
            } else if currentWeather.pm2_5 >  10.00,
                      currentWeather.pm2_5 <= 25.00 {
                pm2_5Index = 2
            } else if currentWeather.pm2_5 >  25.00,
                      currentWeather.pm2_5 <= 50.00 {
                pm2_5Index = 3
            } else if currentWeather.pm2_5 >  50.00,
                      currentWeather.pm2_5 <= 75.00 {
                pm2_5Index = 4
            }
            else if currentWeather.pm2_5 >= 75.00 {
                pm2_5Index = 5
            }
            /// Finner o3Index
            ///
            if currentWeather.o3 < 60.00 {
                o3Index = 1
            } else if currentWeather.o3 >  60.00,
                      currentWeather.o3 <= 100.00 {
                o3Index = 2
            } else if currentWeather.o3 >  100.00,
                      currentWeather.o3 <= 140.00 {
                o3Index = 3
            } else if currentWeather.o3 >  140.00,
                      currentWeather.o3 <= 180.00 {
                o3Index = 4           
            }
            else if currentWeather.o3 >= 180.00 {
                o3Index = 5
            }
            /// Finner co3Index
            ///
            if currentWeather.co < 4400.00 {
                coIndex = 1
            } else if currentWeather.co >  4400.00,
                      currentWeather.co <= 9400.00 {
                coIndex = 2
            } else if currentWeather.co >  9400.00,
                      currentWeather.co <= 12400.00 {
                coIndex = 3
            } else if currentWeather.co >  12400.00,
                      currentWeather.co <= 15400.00 {
                coIndex = 4
            }
            else if currentWeather.co >= 15400.00 {
                coIndex = 5
            }
        }
    }
}

@ViewBuilder
var AirQualityGenerally: some View {
    Text("When talking about air quality, we commonly mean the levels of different pollutants in our air. Major air pollutants include carbon monoxide (CO), ammonia (NH3), nitric oxide (NO), nitrogen dioxide (NO2), ozone (O3), particulate matter (PM), sulphur dioxide (SO2) and volatile organic compounds (VOC).")
        .foregroundColor(.red)
}

