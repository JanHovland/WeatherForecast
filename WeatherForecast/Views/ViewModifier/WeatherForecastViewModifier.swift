//
//  WeatherForecastViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/01/2023.
//

import SwiftUI

struct WeatherForecastViewModifier : ViewModifier {
    var withNavigationView : Bool
    
    init(withNavigationView : Bool) {
        self.withNavigationView = withNavigationView
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if (withNavigationView){
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
        else {
            content
        }
    }
}
