//
//  DayDetailDayDataView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 01/11/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailDayDataView: View {
    
    let weather: Weather
    let option: EnumType
    @Binding var index: Int
    @Binding var colorsForeground : [Color]
    @Binding var colorsForegroundStandard : [Color]
    @Binding var colorsBackground : [Color]
    @Binding var colorsBackgroundStandard : [Color]
    @Binding var dayDetailHide : Bool
    @Binding var selectedValue : SelectedValue
    @Binding var weekdayArray: [String]
    @Binding var windInfo: [WindInfo]
    @Binding var tempInfo: [Temperature]
    @Binding var gustInfo: [Double]
    @Binding var feltTempArray: [FeltTemp]
    @Binding var opacity: Double
    @Binding var dewPointArray: [Double]

    @State private var width: CGFloat = 0.00
    @State private var height: CGFloat = 0.00
    @State private var bottom: CGFloat = 0.00
    
    @State private var option1: EnumType = .number12
    
    var body: some View {
        VStack (alignment: .center) {
            /// 
            /// https://swdevnotes.com/swift/2021/add-axes-to-bar-chart-swiftui/
            /// Viser Chart for Temperatur:
            ///
            DayDetailChart(dayDetailHide: $dayDetailHide,
                           option: option,
                           index: $index,
                           selectedValue: $selectedValue,
                           weekdayArray: $weekdayArray,
                           windInfo: $windInfo,
                           tempInfo: $tempInfo,
                           gustInfo: $gustInfo,
                           weather: weather,
                           feltTempArray: $feltTempArray,
                           opacity: $opacity,
                           dewPointArray: $dewPointArray,
                           colorsForeground : $colorsForeground,
                           colorsForegroundStandard : $colorsForegroundStandard,
                           colorsBackground : $colorsBackground,
                           colorsBackgroundStandard : $colorsBackgroundStandard)
                          /// Oppdaterer dayArray ved en endring fra menuen:
            ///
            .onChange(of: option) { oldOption, option in
                /// Resetter selectedValue fra gesture i DayDetailChart():
                ///
                selectedValue.icon = ""
                selectedValue.value1 = ""
                selectedValue.value2 = ""
                selectedValue.value3 = ""
                selectedValue.time = ""
            }
            .onChange(of: index) { oldIndex, index in
                /// Resetter selectedValue fra gesture i DayDetailChart():
                ///
                selectedValue.icon = ""
                selectedValue.value1 = ""
                selectedValue.value2 = ""
                selectedValue.value3 = ""
                selectedValue.time = ""
            }
        }
        .task {
            /// Setter opp spacing og padding for iPhone og iPad:
            ///
            if UIDevice.isIpad {
                width =  505
                height = 400 // 600 // 400
                bottom = 5
            } else {
                width = 355
                height = 360
                bottom = 110
            }
        }
        .frame(maxWidth: .infinity,           //width,
               maxHeight: height)
    }
}
