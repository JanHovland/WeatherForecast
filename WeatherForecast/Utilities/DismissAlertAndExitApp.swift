//
//  DismissAlertAndExitApp.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/12/2023.
//

import SwiftUI

/// Avslutter appen etter valgte sekunder
/// - Parameters:
///   - seconds: Antall sekunder til appen blir avsluttet korrekt
///   - alert: Alert variable som skal settes til false
func DismissAlertAndExitApp(seconds: Double, alert:  inout Bool) {
    alert = false
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        ///
        /// https://stackoverflow.com/questions/73061848/quit-an-app-swift-programmatically-without-crash-log-in-firebase
        ///** If you use exit(0), your application will be rejected due to the following reason:
        ///
        /// We found that your app includes a UI control for quitting the app.
        /// This is not in compliance with the iOS Human Interface Guidelines, as required by the App Store Review Guidelines.
        /// To avoid any such rejections, suspend the application using the following code snippet.
        ///     UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        ///
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
