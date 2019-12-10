//
//  Datum.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Datum: Codable, Equatable {
    let time: Double
    let summary: String
    let icon: Icon
    let sunriseTime, sunsetTime: Double
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: Icon
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility, ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

extension Datum {
    var date: Date { Date(timeIntervalSince1970: self.time) }
    var sunriseDate: Date { Date(timeIntervalSince1970: self.sunriseTime) }
    var sunsetDate: Date { Date(timeIntervalSince1970: self.sunsetTime) }
}
