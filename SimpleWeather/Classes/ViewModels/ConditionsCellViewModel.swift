//
//  ConditionsCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/19/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ConditionsCellViewModel {

    let temperature: Double
    let high: Double
    let low: Double
    let conditionImageName: String
    let feelsLike: Double

    var temperatureLabelText: String {
        return String(format: "%.0f°", temperature)
    }

    var highLowLabelText: NSAttributedString {
        return highLowAttributedString(high: high, low: low, size: 18)
    }

    var feelsLikeText: String? {
        return temperature != feelsLike ? String(format: "(%.0f°)", feelsLike) : nil
    }
    
}
