//
//  Icon.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

/*
 A machine-readable text summary of this data point, suitable for selecting an icon for display. If defined, this property will have one of the following values: clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
 */

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case snow, sleet, cloudy, rain, wind, fog
}

extension Icon {
    
    func named(night: Bool) -> String {
        switch self {
        case .clearDay:
            return night ? "Moon" : "Sun"
        case .clearNight:
            return "Moon"
        case .partlyCloudyDay:
            return night ? "Mostly-sunny-night" : "Mostly-sunny-day"
        case .partlyCloudyNight:
            return "Mostly-sunny-night"
        case .snow:
            return "Snow"
        case .cloudy:
            return "Cloudy"
        case .rain:
            return "Mist"
        case .wind:
            return "Wind"
        case .fog:
            return "Haze"
        default:
            return ""
        }
    }
    
}

/*
 
 */
