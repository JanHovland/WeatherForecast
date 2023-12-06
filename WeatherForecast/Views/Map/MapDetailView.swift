//
//  MapDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2023.
//

import SwiftUI
import MapKit

///  https://www.createwithswift.com/using-expanded-swiftui-support-for-mapkit/?ref=create-with-swift-newsletter
///
///  https://github.com/tomha2014/LearnMapKitiOS17
///
///  https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24

struct MapDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    ///
    /// Må initialisere alle @State private var:_
    ///
    @State private var location = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    @State private var regionCenter = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    @State private var regionSpan = MKCoordinateSpan(latitudeDelta: 0.0, longitudeDelta: 0.0)
    ///
    /// position må initialiseres slik:
    ///
    @State private var position: MapCameraPosition =
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.00,
                                                                  longitude: 0.00),
                                   span: MKCoordinateSpan(latitudeDelta: 0.0,
                                                          longitudeDelta: 0.0)))
    
    var body: some View {
        VStack {
            Map (position : $position) {
                ///
                /// Markere posisjonen
                ///
//                Marker(weatherInfo.placeName,
//                       coordinate: location)
//                .annotationTitles(.automatic)
                UserAnnotation()
            }
            ///
            /// Modifier for selve kartet
            ///
            .frame(width: UIDevice.isIpad ? 765 : 370, height: UIDevice.isIpad ? 280 : 230)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapCompass()
                ///
                /// MapUserLocationButton() går tilbake til min posisjon
                ///
                // MapUserLocationButton()
                MapScaleView()
            }
        }
        ///
        /// Modifier for VStack
        ///
        .frame(width: UIDevice.isIpad ? 785 : 390, height: UIDevice.isIpad ? 300 : 250)
        .background(
            RoundedRectangle(cornerRadius: 15,
                             style: .continuous)
            .fill(Color("Background#01").opacity(currentWeather.isDaylight == true ? 0.85 : 0.35))
            .saturation(1)
        )
        .task {
            ///
            /// Oppdaterer location
            ///
            location = CLLocationCoordinate2D(latitude: weatherInfo.latitude ?? 0.00, 
                                              longitude: weatherInfo.longitude ?? 0.00)
            regionCenter =  CLLocationCoordinate2D(latitude: weatherInfo.latitude ?? 0.00, 
                                                   longitude: weatherInfo.longitude ?? 0.00)
            regionSpan = MKCoordinateSpan(latitudeDelta: 0.125, 
                                          longitudeDelta: 0.125)
            position = .region(MKCoordinateRegion(center: regionCenter, span: regionSpan))
        }
    }
}

