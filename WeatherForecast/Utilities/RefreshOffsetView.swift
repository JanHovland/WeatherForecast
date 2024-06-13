//
//  RefreshOffsetView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 25/10/2023.
//

import SwiftUI

struct RefreshOffsetView: View {

    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    @State private var opacityIndicator: Double = 0.00
    @State private var places = [Place]()
    
    @State private var info = String(localized: "The time zones are set relative to UTC.\n\nUTC is often used to indicate time zones and then indicates the deviation from the time as it is indicated at the prime meridian. UTC is thus the successor to Greenwich Mean Time (GMT).\n\nExample for Norway:\n\nCET (Central European Time) = UTC+1h.\n\nDaylight Saving Time:\n\nCEST (Central European Summer Time) = UTC+2h")
       
    var body: some View {
        ActivityIndicator(opacity: $opacityIndicator)
        VStack {
            HStack {
                Spacer()
                Text("Refresh the offset in CloudKit")
                    .font(.title)
                Spacer()
            }
            Spacer()
            
            Text(info)
                .padding(.horizontal,60)
                .font(.callout.italic())
                .offset(y: -50)
            
            
            VStack {
                Button {
                    ///
                    /// Rutine for å starte RefreshOffset()
                    ///
                    Task.init {
                        ///
                        /// Viser ActivityIndicator:
                        ///
                        opacityIndicator = 1.0
                        
                        ///
                        /// Markerer starten :
                        ///
                        title = "Refresh offset for places"
                        message = "Reset offset for the places has started.\n\nPlease note that this alert will only show for a few seconds."
                        showAlert.toggle()
                        dismissAlert(seconds: 5)
                        ///
                        /// Begynner på modifiseringen:
                        ///
                        let value: (Bool, LocalizedStringKey)
                        value = await RefreshOffset()
                        if value.0 == false {
                            title = "Refresh offset for places"
                            message = value.1
                            showAlert.toggle()
                        } else {
                            ///
                            /// Markerer slutten:
                            ///
                            title = "Refresh offset for places"
                            message = value.1
                            showAlert.toggle()
                        }

                        ///
                        /// Skjuler ActivityIndicator:
                        ///
                        opacityIndicator = 0.0
                    }
                } label: {
                    Text("Start refreshing")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .background(.placeholder)
                .clipShape(Capsule())
                .offset(y: UIDevice.isIpad ?  50 : 0)
            }
            Spacer()
        }
        .offset(y: 20)
        .alert(title, isPresented: $showAlert) {
        }
        message: {
           Text(message)
        }
    }
    
    func dismissAlert(seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            showAlert = false
        }
    }
}

