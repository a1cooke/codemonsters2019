//
//  Currently.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Currently: Codable {
    let time: Double
    let summary: String
    let icon: Icon
    let nearestStormDistance, nearestStormBearing: Double?
    let precipIntensity: Double
    let precipIntensityError: Double?
    let precipProbability: Double
    let precipType: Icon?
    let temperature, apparentTemperature, dewPoint, humidity: Double
    let pressure, windSpeed, windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Double
    let visibility, ozone: Double
}

extension Currently {
    var date: Date { Date(timeIntervalSince1970: self.time) }
    var wind: Wind { Wind(speed: self.windSpeed, directionDegrees: windBearing) }
    var humidityPercentage: String { String(format: "%.0f%", self.humidity)}
}
