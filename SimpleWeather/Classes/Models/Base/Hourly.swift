//
//  Hourly.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Hourly: Codable {
    let summary: String
    let icon: Icon
    let data: [Currently]
}
