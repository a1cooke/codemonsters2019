//
//  WeatherSearchRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 04/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherSearchRobot {
    
    private var application: XCUIApplication { XCUIApplication() }

    @discardableResult
    func searchForLocation(query: String) -> Self {
        let searchForLocationsSearchField = application.navigationBars["SimpleWeather.SearchView"].searchFields["Search for locations"]
        searchForLocationsSearchField.tap()
        searchForLocationsSearchField.typeText(query)
        
        return self
    }
    
    @discardableResult
    func selectLocation(location: String) -> WeatherListRobot {
        application.collectionViews.staticTexts["Sofia, Bulgaria"].tap()
        return WeatherListRobot()
    }
}
