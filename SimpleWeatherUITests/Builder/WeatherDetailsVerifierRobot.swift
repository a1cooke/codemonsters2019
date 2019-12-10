//
//  WeatherDetailsVerifierRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 09/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherDetailsVerifierRobot {
    
    private var application: XCUIApplication { XCUIApplication() }
    
    @discardableResult
    func verifyWeatherDetailsExpanded() -> Self {
        
        let collectionViewsQuery = application.collectionViews
        
        //Simple example, can be expanded for the complete feature
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Feels Like")
        let elementQuery = collectionViewsQuery.staticTexts.containing(predicate)
        
        //Assert that feels like string is present
        XCTAssertTrue(elementQuery.count == 1)
        
        return self
    }
    
}
