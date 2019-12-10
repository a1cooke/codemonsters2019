//
//  ForecastDayCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/20/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

enum ForecastDayCellPosition {
    case top, bottom, none
}

struct ForecastDayCellViewModel {

    static private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df
    }()

    let date: Date
    let temperatureHigh: Double
    let temperatureLow: Double
    let conditionImageName: String
    let precipProbability: Double
    let position: ForecastDayCellPosition

    var dateString: String {
        return ForecastDayCellViewModel.dateFormatter.string(from: date)
    }

    var highLowConditionsString: NSAttributedString {
        return highLowAttributedString(high: temperatureHigh, low: temperatureLow, size: 15)
    }

    var precipString: String? {
        return precipProbability >= 0.2 ? String(format: "%.0f%%", precipProbability * 100.0) : nil
    }

}
