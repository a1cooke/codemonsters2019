//
//  Wind.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Wind: Equatable {
    let speed: Double
    let directionDegrees: Double
    
    private static let directionStrings: [String] = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW", "N"]
    
    var direction: String {
        var index = directionDegrees.truncatingRemainder(dividingBy: 360.0)
        index = round(index / 22.5)
        if let arrayIndex: Int = Int(exactly: index) {
            return arrayIndex < Wind.directionStrings.count ? Wind.directionStrings[arrayIndex] : ""
        }
        return ""
    }
    
}
