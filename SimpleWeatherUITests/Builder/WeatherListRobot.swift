//
//  WeatherListRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 04/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherListRobot {
    
    private var application: XCUIApplication { XCUIApplication() }
    
    @discardableResult
    func selectLocation(city: String) -> WeatherDetailsRobot {
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.scrollViews.otherElements.staticTexts[city].tap()
        
        return WeatherDetailsRobot()
    }
    
    @discardableResult
    func selectSearch() -> WeatherSearchRobot {
        let addButton = application.navigationBars["Locations"].buttons["Add"]
        addButton.tap()
        return WeatherSearchRobot()
    }
    
    @discardableResult
    func deleteLocation(city: String) -> Self {
        
        let scrollViewsQuery = XCUIApplication().collectionViews.scrollViews
        scrollViewsQuery.otherElements.staticTexts[city].swipeRight()
        scrollViewsQuery.otherElements.containing(.staticText,
                                                  identifier:city).children(matching: .other).element.children(matching: .other).element.children(matching: .map).element.swipeLeft()
        XCUIApplication().collectionViews.children(matching: .cell)
            .element(boundBy: 3).scrollViews.otherElements.containing(.staticText, identifier:"Delete").element.tap()
        
        return self
    }
}
