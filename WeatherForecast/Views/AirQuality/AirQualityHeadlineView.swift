//
//  AirQualityHeadlineView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import SwiftUI

struct AirQualityHeadlineView: View {
    var body: some View {
    HStack {
        HStack {
            Text("Designation")
            Spacer()
        }
        HStack {
            Spacer()
            Text("Index")
            Spacer()
        }
        HStack {
            Spacer()
            Text(aqUnit)
            Spacer()
        }
        HStack {
            Spacer()
            Text("Range")
        }
    }
    .foregroundColor(.secondary)
    .font(.footnote)
    .padding(.horizontal, 10)
}}
