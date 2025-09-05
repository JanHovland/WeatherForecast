//
//  Extensions.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/10/2022.
//

import UIKit
import SwiftUI
import WeatherKit
import CoreLocation

extension UIDevice {
  
  static var idiom: UIUserInterfaceIdiom {
    UIDevice.current.userInterfaceIdiom
  }
  
  static var isIpad: Bool {
    idiom == .pad
  }
  
  static var isiPhone: Bool {
    idiom == .phone
  }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

/// Finn et tegn i en streng:
///    let greeting = "16:31"
///    let a = greeting[0] ----> "1"
///    let b = greeting[1] ----> "6"
///    let c = greeting[2]  ----> ":"
///    let d = greeting[3] ----> "3"
///    let e = greeting[4] ----> "1"
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}

extension Date {
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
}

///
/// Hindre compiler warnings eksempel:
///  Non-sendable type 'Weather' exiting main actor-isolated context in call to non-isolated global function '' cannot cross actor boundary
///  Non-sendable type 'CLLocation' exiting main actor-isolated context in call to non-isolated global function '' cannot cross actor boundary
///  Non-sendable type 'Forecast<HourWeather>' exiting main actor-isolated context in call to non-isolated global function '' cannot cross actor boundary
///  Non-sendable type 'WeatherQuery>' exiting main actor-isolated context in call to non-isolated global function '' cannot cross actor boundary
///
/// @MainActor
/// var teller: Int = 0
///
/// func incrementCounter() {
///      teller = 1
/// }
///
/// I dette eksemplet er tellervariabelen kommentert med @MainActor,
/// noe som betyr at den kun kan åpnes og endres fra hovedtråden.
/// IncrementCounter-funksjonen kan kalles fra hvilken som helst tråd,
/// men den vil alltid bli utført på hovedtråden, takket være
/// @MainActor-kommentaren på tellervariabelen.
///
/// Totalt sett er @MainActor et kraftig verktøy for å administrere
/// samtidighet i SwiftUI-apper, siden det bidrar til å sikre at
/// UI-oppdateringer utføres trygt og effektivt på hovedtråden.
///
/// I tillegg må det legges inn @MainActor foran hver func i CloudKitPlaceHelper()
///
// extension Weather: @unchecked Sendable {}
// extension CLLocation: @unchecked Sendable {}
// extension Forecast<HourWeather>: @unchecked Sendable {}
// extension Forecast<DayWeather>: @unchecked Sendable {}
// extension WeatherQuery: @unchecked Sendable {}


extension Date {
    
    func adding(seconds: Int) -> Date {
        Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }

    func adding(minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func adding(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func localOffset() -> Int {
        Calendar.current.timeZone.secondsFromGMT()
    }

}

extension LocalizedStringKey {

    // This will mirror the `LocalizedStringKey` so it can access its
    // internal `key` property. Mirroring is rather expensive, but it
    // should be fine performance-wise, unless you are
    // using it too much or doing something out of the norm.
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

