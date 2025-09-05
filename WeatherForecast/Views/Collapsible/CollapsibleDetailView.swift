//
//  CollapsibleDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/12/2023.
//

import SwiftUI

struct CollapsibleDetailView: View {
    @Binding var title: String
    @Binding var content: String
    @Binding var show: Bool
    
    var body: some View {
        
        Section(
            header: CollapsibleHeader(
                title: $title,
                isOn: $show
            )
        ) {
            if show {
                Text(content)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 5,
                                         style: .continuous)
                        .fill(Color("LightYellow"))
                        .saturation(1)
                    )
                    .padding(.top, 20)
            }
        }
    }
}

