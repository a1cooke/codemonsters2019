//
//  ForecastDayCellViewModel+Equatable.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/21/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ForecastDayCellViewModel: Equatable {

    public static func ==(lhs: ForecastDayCellViewModel, rhs: ForecastDayCellViewModel) -> Bool {
        return lhs.date == rhs.date
            && lhs.temperatureHigh == rhs.temperatureHigh
            && lhs.temperatureLow == rhs.temperatureLow
            && lhs.conditionImageName == rhs.conditionImageName
    }

}
