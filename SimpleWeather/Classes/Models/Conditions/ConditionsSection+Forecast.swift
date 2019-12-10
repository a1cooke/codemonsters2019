//
//  ConditionsSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/11/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ConditionsSection {

    static func from(weather: Weather?) -> ConditionsSection? {
        guard let currently = weather?.currently, let today = weather?.daily.data.sorted(by: { $0.time < $1.time }).first else { return nil }

        return ConditionsSection(
            temperature: currently.temperature,
            high: today.temperatureHigh,
            low: today.temperatureLow,
            icon: currently.icon,
            feelsLike: currently.apparentTemperature,
            wind: currently.wind,
            date: currently.date,
            humidity: currently.humidityPercentage,
            dewpoint: currently.dewPoint,
            pressure: currently.pressure,
            visibility: currently.visibility,
            precip_1hr: currently.precipProbability,
            description: currently.summary,
            timeOfDay: Date().timeOfDay(sunrise: today.sunriseDate, sunset: today.sunsetDate)
        )
    }
    
}
