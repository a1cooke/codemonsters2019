//
//  Alerts.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 29/11/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Alerts: Codable {
    let description: String
    let expires: Int
    let regions: [String]
    let severity: Severity
    let time: Double
    let title: String
    let uri: String
}

enum Severity: String, Codable {
    case advisory, watch, warning
}

extension Alerts {
    var date: Date { Date(timeIntervalSince1970: self.time) }
}
