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
///
///  https://www.youtube.com/watch?v=rWpfyJ8xoj0

struct MapDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    ///
    /// Må initialisere alle @State private var: 
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
    
    @State private var pinLocation = CLLocationCoordinate2D()
    
    var body: some View {
        VStack {
            MapReader { reader in
                Map (position : $position,
                     interactionModes: .all) {
                }
                ///
                /// Simulerer en "Meny" oppe til venstre
                ///
                .overlay (alignment: .topTrailing) {
                    Button(action: {
                    }) {
                        HStack {
                            Text("Tap for info")
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                                .opacity(0.50)
                        }
                    }
                    .padding(5)
                    .background()
                    .cornerRadius(10)
                    .font(.caption2)
                }
                ///
                /// Modifier for selve kartet
                ///
                .onTapGesture(perform: { screenCoord in
                    ///
                    /// Finner koordinatene og  deretter informasjon om stedet
                    ///
                    pinLocation = reader.convert(screenCoord, from: .local)!
                    MapFetchInformation(latitude: pinLocation.latitude, longitude: pinLocation.longitude)
                })
            }
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapCompass()
                MapScaleView()
                MapPitchToggle()
            }
            .frame(height: UIDevice.isIpad ? 300 : 250)
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
}
