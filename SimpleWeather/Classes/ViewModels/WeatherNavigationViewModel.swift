//
//  WeatherNavigationViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func WeatherNavigationTitle(location: SavedLocation, weather: Weather?) -> String? {
    if location.userLocation == true {
        if let weather = weather {
            return ""
        } else {
            return NSLocalizedString("Loading...", comment: "")
        }
    } else {
        return location.name
    }
}

func WeatherNavigationShouldDisplayAlerts(weather: Weather?) -> Bool {
    
    guard let alerts = weather?.alerts else { return false }
    
    return alerts.count > 0
    
}
