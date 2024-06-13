//
//  ServerResponse.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/03/2023.
//

import Foundation
import SwiftUI


func ServerResponse(error: String) -> LocalizedStringKey {
    ///
    /// Server error responses:
    ///
    var serverError: LocalizedStringKey = ""
    
    if error.contains("500") {
        serverError =  "500 Internal Server Error,\nThe server has encountered a situation it does not know how to handle."
    } else if error.contains("501") {
        serverError = "501 Not Implemented,\nThe request method is not supported by the server and cannot be handled. The only methods that servers are required to support (and therefore that must not return this code) are GET and HEAD."
    } else if error.contains("502") {
        serverError = "502 Bad Gateway,\nThis error response means that the server, while working as a gateway to get a response needed to handle the request, got an invalid response."
    } else if error.contains("503") {
        serverError = "503 Service Unavailable,\nThe server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded. Note that together with this response, a user-friendly page explaining the problem should be sent. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time before the recovery of the service. The webmaster must also take care about the caching-related headers that are sent along with this response, as these temporary condition responses should usually not be cached."
    } else if error.contains("504") {
        serverError = "504 Gateway Timeout,\nThis error response is given when the server is acting as a gateway and cannot get a response in time."
    } else if error.contains("505") {
        serverError = "505 HTTP Version Not Supported,\nThe HTTP version used in the request is not supported by the server."
    } else if error.contains("506") {
        serverError = "506 Variant Also Negotiates,\nThe server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process."
    } else if error.contains("507") {
        serverError = "507 Insufficient Storage (WebDAV),\nThe method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request."
    } else if error.contains("508") {
        serverError = "508 Loop Detected (WebDAV),\nThe server detected an infinite loop while processing the request."
    } else if error.contains("510") {
        serverError = "510 Not Extended,\nFurther extensions to the request are required for the server to fulfill it."
    } else if error.contains("511") {
        serverError = "511 Network Authentication Required,\nIndicates that the client needs to authenticate to gain network access."
    }
    
    return serverError
}
