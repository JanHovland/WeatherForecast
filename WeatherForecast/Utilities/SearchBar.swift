//
//  SearchBar.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/02/2023.
//

import SwiftUI

struct SearchBar: View {
    ///
    /// https://www.appcoda.com/swiftui-search-bar/
    ///
    /// https://www.youtube.com/watch?v=iTqwa0DCIMA
    ///
    @Binding var searchText: String
    @State  var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchText = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
        }
        .padding(.horizontal, 10)
    }
}

