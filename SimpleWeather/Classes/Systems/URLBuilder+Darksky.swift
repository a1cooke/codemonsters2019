//
//  URLBuilder+Darksky.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func DarkSkyURL(
    apiKey: String,
    paths: [String]? = nil,
    query: [String: String]? = nil
    ) -> URL? {
    let apiPaths = ["forecast", apiKey] + (paths ?? [])
    return URLBuilder(base: "https://api.darksky.net/", paths: apiPaths, query: query)
}

func DarkSkyForecastURL(
    apiKey: String,
    lat: Double,
    lon: Double
    ) -> URL? {
    let paths = [
        String(format: "%.4f,%.4f", lat, lon)]
    let query = [
        "units": "si",
        "exclude": ["minutely"].joined(separator: ","),
    ]
    return DarkSkyURL(apiKey: apiKey, paths: paths, query: query)
}
