//
//  File.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
    let flags: Flags
    let offset: Int
    let alerts: [Alerts]?
}
