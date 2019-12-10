//
//  WeatherListVerifiierRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 09/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class WeatherListVerifiierRobot {
    
    private var application: XCUIApplication { XCUIApplication() }
    
    @discardableResult
    func verifyLocationsVisible(cities: String...) -> Self {
        let collectionViewsQuery = application.collectionViews
        
        for city in cities {
            sleep(5)
            let predicate = NSPredicate(format: "label CONTAINS[c] %@", city)
            let elementQuery = collectionViewsQuery.scrollViews.otherElements.staticTexts.containing(predicate)
            
            //Assert that there is no city
            XCTAssertTrue(elementQuery.count == 1)
        }
        
        return self
    }
    
    @discardableResult
    func verifyLocationGone(city: String) -> Self {
        
        sleep(5)
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", city)
        let elementQuery = collectionViewsQuery.scrollViews.otherElements.staticTexts.containing(predicate)
                
        //Assert that there is no city
        XCTAssertTrue(elementQuery.count == 0)
        
        return self
    }
    
}
