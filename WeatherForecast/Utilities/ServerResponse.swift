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

    let searchFor = "Status Code:"
    serverError = Response(response: error, searchFor: searchFor)
    
    return serverError
    
    
//    if error.contains("500") {
//        serverError =  "500 Internal Server Error,\nThe server has encountered a situation it does not know how to handle."
//    } else if error.contains("501") {
//        serverError = "501 Not Implemented,\nThe request method is not supported by the server and cannot be handled. The only methods that servers are required to support (and therefore that must not return this code) are GET and HEAD."
//    } else if error.contains("502") {
//        serverError = "502 Bad Gateway,\nThis error response means that the server, while working as a gateway to get a response needed to handle the request, got an invalid response."
//    } else if error.contains("503") {
//        serverError = "503 Service Unavailable,\nThe server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded. Note that together with this response, a user-friendly page explaining the problem should be sent. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time before the recovery of the service. The webmaster must also take care about the caching-related headers that are sent along with this response, as these temporary condition responses should usually not be cached."
//    } else if error.contains("504") {
//        serverError = "504 Gateway Timeout,\nThis error response is given when the server is acting as a gateway and cannot get a response in time."
//    } else if error.contains("505") {
//        serverError = "505 HTTP Version Not Supported,\nThe HTTP version used in the request is not supported by the server."
//    } else if error.contains("506") {
//        serverError = "506 Variant Also Negotiates,\nThe server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process."
//    } else if error.contains("507") {
//        serverError = "507 Insufficient Storage (WebDAV),\nThe method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request."
//    } else if error.contains("508") {
//        serverError = "508 Loop Detected (WebDAV),\nThe server detected an infinite loop while processing the request."
//    } else if error.contains("510") {
//        serverError = "510 Not Extended,\nFurther extensions to the request are required for the server to fulfill it."
//    } else if error.contains("511") {
//        serverError = "511 Network Authentication Required,\nIndicates that the client needs to authenticate to gain network access."
//    }
    
//    serverError = "Error = \(error)"

//    let msg = "\(error)"
//    
//    let range = msg.range(of: "Status Code:")
//    let index = msg.distance(from: msg.startIndex, to: range.lowerBound)
}

func Response(response: String,
              searchFor: String) -> LocalizedStringKey {
    
    var serverResponse: LocalizedStringKey = ""
    let range = response.range(of: searchFor)
    var index: Int = 0
    
    if let range = range {
        index = response.distance(from: response.startIndex, to: range.lowerBound)
    }
    
    let startIndex = response.index(response.startIndex, offsetBy: index)
    let endIndex = response.index(response.startIndex, offsetBy: index + 16)
    let substring = String(response[startIndex..<endIndex])
    
    serverResponse = ResponseInfo(string: substring)
    
    return serverResponse
}

func CatchResponse(response: String,
                   searchFrom: String,
                   searchTo: String) -> String {
    
    var serverResponse: String = ""

    let range = response.range(of: searchFrom)
    let range1 = response.range(of: searchTo)

    var index: Int = 0
    var index1: Int = 0

    if let range = range {
        index = response.distance(from: response.startIndex, to: range.lowerBound)
    }

    if let range1 = range1 {
        index1 = response.distance(from: response.startIndex, to: range1.lowerBound)
    }

    let startIndex = response.index(response.startIndex, offsetBy: index)
    let endIndex = response.index(response.startIndex, offsetBy: index1)
    let substring = String(response[startIndex..<endIndex])
    
    serverResponse = substring
    
    return serverResponse
}


func ResponseInfo(string: String) -> LocalizedStringKey {
    
    /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    /// https://no.wikipedia.org/wiki/Liste_over_HTTP-statuskoder
    
    ///  HTTP response status codes indicate whether a specific HTTP request has been successfully completed. Responses are grouped in five classes:
    ///
    ///  Informational responses (100 – 199)
    ///  Successful responses (200 – 299)
    ///  Redirection messages (300 – 399)
    ///  Client error responses (400 – 499)
    ///  Server error responses (500 – 599)
    
    var response: LocalizedStringKey = ""
    
    
    if string.contains("200") {
        response = "Error = 200 OK"
    }
    
    if string.contains("400") {
        response = "Error code = 400 Bad Request"
    } else if string.contains("401") {
        response = "Error code = 401 Unauthorized"
    } else if string.contains("402") {
        response = "Error code = 402 Payment Required"
    } else if string.contains("403") {
        response = "Error code = 403 Forbidden"
    } else if string.contains("404") {
        response = "Error code = 404 Not Found"
    } else if string.contains("405") {
        response = "Error code = 405 Method Not Allowed"
    } else if string.contains("406") {
        response = "Error code = 406 Not Acceptable"
    } else if string.contains("407") {
        response = "Error code = 407 Proxy Authentication Required"
    } else if string.contains("408") {
        response = "Error code = 408 Request Timeout"
    } else if string.contains("409") {
        response = "Error code = 409 Conflict"
    } else if string.contains("410") {
        response = "Error code = 410 Gone"
    } else if string.contains("411") {
        response = "Error code = 411 Length Required"
    } else if string.contains("412") {
        response = "Error code = 412 Precondition Failed"
    } else if string.contains("413") {
        response = "Error code = 413 Payload Too Large"
    } else if string.contains("414") {
        response = "Error code = 414 URI Too Long"
    } else if string.contains("415") {
        response = "Error code = 415 Unsupported Media Type"
    } else if string.contains("416") {
        response = "Error code = 416 Range Not Satisfiable"
    } else if string.contains("417") {
        response = "Error code = 417 Expectation Failed"
    } else if string.contains("418") {
        response = "Error code = 418 I'm a teapot"
    } else if string.contains("421") {
        response = "Error code = 421 Misdirected Request"
    } else if string.contains("422") {
        response = "Error code = 422 Unprocessable Content (WebDAV)"
    } else if string.contains("423") {
        response = "Error code = 423 Locked (WebDAV)"
    } else if string.contains("424") {
        response = "Error code = 424 Failed Dependency (WebDAV)"
    } else if string.contains("425") {
        response = "Error code = 425 Too Early "
    } else if string.contains("426") {
        response = "Error code = 426 Upgrade Required"
    } else if string.contains("428") {
        response = "Error code = 428 Precondition Required"
    } else if string.contains("429") {
        response = "Error code = 429 Too Many Requests"
    } else if string.contains("431") {
        response = "Error code = 431 Request Header Fields Too Large"
    } else if string.contains("451") {
        response = "Error code = 451 Unavailable For Legal Reasons"
    }

    return response
    
}
