//
//  EvolvedWeatherListRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class EvolvedWeatherListRobot {

    @ConstructionWrapper
    private var application: XCUIApplication
    
    @discardableResult
    func selectLocation(city: String) -> WeatherDetailsRobot {
        let collectionViewsQuery = application.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.scrollViews/*[[".cells.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.staticTexts[city].tap()
        
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
        
        let scrollViewsQuery = application.collectionViews/*@START_MENU_TOKEN@*/.scrollViews/*[[".cells.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        scrollViewsQuery.otherElements.staticTexts["Dublin"].swipeRight()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Dublin").children(matching: .other).element.children(matching: .other).element.children(matching: .map).element.swipeLeft()
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 3).scrollViews.otherElements.containing(.staticText, identifier:"Delete").element.tap()
                        
        
        
        return self
    }
    
}

extension EvolvedWeatherListRobot {
    convenience init(_ closure: (EvolvedWeatherListRobot) -> Void) {
        self.init()
        closure(self)
    }
}
