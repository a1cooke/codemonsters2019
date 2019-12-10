//
//  WeatherDetailsRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 04/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherDetailsRobot {
    
    private var application: XCUIApplication { XCUIApplication() }
    var isExpanded = false
    
    @discardableResult
    func expandWeatherDetails() -> Self {
        application.collectionViews.cells.otherElements.containing(.image, identifier:"Arrow").element.tap()
        isExpanded = true
        return self
    }
    
    @discardableResult
    func collapseWeatherDetails() -> Self {
        application.collectionViews.cells.otherElements.containing(.image, identifier:"Arrow").element.tap()
        isExpanded = false
        return self
    }
    
    @discardableResult
    func navigateBack() -> WeatherListRobot {
        return WeatherListRobot()
    }
    
}
