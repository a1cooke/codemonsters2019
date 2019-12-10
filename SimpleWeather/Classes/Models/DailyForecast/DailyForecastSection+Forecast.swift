//
//  DailyForecastSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/21/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension DailyForecastSection {

    static func from(weather: Weather) -> DailyForecastSection? {

        let daily = weather.daily.data.sorted(by: { $0.date < $1.date })
        let date = weather.currently.date
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.day]
        let observationDay = calendar.dateComponents(components, from: date).day

        var viewModels = [ForecastDayCellViewModel]()
        let limit = 10
        for day in daily {
            let count = viewModels.count
            // dont include daily forecasts when already have observations
            guard count < limit else { break }
            guard observationDay != calendar.dateComponents(components, from: day.date).day else { continue }

            let isFirst = count == 0
            let isLast = count == limit - 2 || day == daily.last
            let position: ForecastDayCellPosition = isFirst ? .top : isLast ? .bottom : .none

            // TODO Fix me
            let viewModel = ForecastDayCellViewModel(
                date: day.date,
                temperatureHigh: day.temperatureHigh,
                temperatureLow: day.temperatureLow,
                conditionImageName: day.icon.named(night: false),
                precipProbability: day.precipProbability,
                position: position
            )
            viewModels.append(viewModel)
        }
        return DailyForecastSection(
            currentDate: date,
            viewModels: viewModels
        )
    }

}
