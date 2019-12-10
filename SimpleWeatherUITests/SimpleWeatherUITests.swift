//
//  SimpleWeatherUITests.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class SimpleWeatherUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let application = XCUIApplication()
        application.launch()
    }
    
    func testSelectSavedCityDisplaysCorrectly() {

        //Given
        let city = "Dublin"
        let application = XCUIApplication()
        
        //When
        let collectionViewsQuery = application.collectionViews
        collectionViewsQuery.scrollViews.otherElements.staticTexts[city].tap()

        collectionViewsQuery.cells.otherElements.containing(.image, identifier:"Arrow").element.tap()
        
        //Then
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Feels Like")
        let elementQuery = collectionViewsQuery.staticTexts.containing(predicate)
        XCTAssertTrue(elementQuery.count == 1)
        
    }

    func testDeleteSavedCity() {
        
        //Given
        let city = "Dublin"
        let application = XCUIApplication()
        
        //When
        let scrollViewsQuery = application.collectionViews.scrollViews
        scrollViewsQuery.otherElements.staticTexts[city].swipeRight()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:city).children(matching: .other).element.children(matching: .other).element.children(matching: .map).element.swipeLeft()
        
        application.collectionViews.children(matching: .cell).element(boundBy: 3).scrollViews.otherElements.containing(.staticText, identifier:"Delete").element.tap()
        
        let collectionViewsQuery = application.collectionViews
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", city)
        let elementQuery = collectionViewsQuery.scrollViews.otherElements.staticTexts.containing(predicate)
        
        //Assert that there is no city
        XCTAssertTrue(elementQuery.count == 0)
    }
    
    func testSearchForCityAndSave() {

        //Given
        let citySearch = "Sofia, Bulgaria"
        let cityTitle =  "Sofia"
        let application = XCUIApplication()
        
        //When
        let addButton = application.navigationBars["Locations"].buttons["Add"]
        addButton.tap()
        
        let searchForLocationsSearchField = application.navigationBars["SimpleWeather.SearchView"].searchFields["Search for locations"]
        searchForLocationsSearchField.tap()
        searchForLocationsSearchField.typeText(citySearch)
        
        let searchResult = application.collectionViews.staticTexts["Sofia, Bulgaria"]
        searchResult.tap()
        
        //Then
        let collectionViewsQuery = application.collectionViews
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", cityTitle)
        let elementQuery = collectionViewsQuery.scrollViews.otherElements.staticTexts.containing(predicate)
        
        waitForElementToAppear(element: collectionViewsQuery.scrollViews.otherElements.staticTexts["Sofia"])
        
        //Assert that there is no city
        XCTAssertTrue(elementQuery.count == 1)
        
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
    
}


