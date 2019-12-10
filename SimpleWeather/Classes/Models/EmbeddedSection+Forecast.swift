//
//  EmbeddedSection+Weather.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension EmbeddedSection {

    static func from(weather: Weather) -> EmbeddedSection? {
        


        let hourly = weather.hourly.data.sorted(by: { $0.time < $1.time })
        var viewModels = [ForecastHourCellViewModel]()

        if let firstDay = weather.daily.data.first {
            
            let sunrise = firstDay.sunriseDate
            let sunset = firstDay.sunsetDate
            let limit = 12
            for hour in hourly {
                //TODO Fix me
                let timeOfDay = hour.date.timeOfDay(sunrise: sunrise, sunset: sunset)
                let viewModel = ForecastHourCellViewModel(
                    date: hour.date,
                    temp: hour.temperature,
                    conditionImageName: hour.icon.named(night: (timeOfDay == .night)),
                    chancePrecip: hour.precipProbability
                )
                viewModels.append(viewModel)
                if viewModels.count >= limit { break }
            }
        }
        

        return EmbeddedSection(identifier: "hourly" as NSString, items: viewModels)
    }
    
}

