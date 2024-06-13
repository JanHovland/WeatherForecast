//
//  CollapsibleView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/12/2023.
//

import SwiftUI

struct CollapsibleView: View {
    @Binding var showSection: Bool
    @Binding var title: String
    @Binding var content: String
    
    var body: some View {
        VStack {
            CollapsibleDetailView(title: $title, content: $content, show: $showSection)
        }
        .padding(.leading, 10)
        .padding(.top, 10)
    }
}


