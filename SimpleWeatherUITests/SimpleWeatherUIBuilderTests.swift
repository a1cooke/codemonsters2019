//
//  SimpleWeatherUIBuilderTests.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class SimpleWeatherUIBuilderTests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
    }
    
    func testSelectSavedCityDisplaysCorrectly() {
        //Given
        let listRobot = WeatherListRobot();
        let verifyDetailsRobot = WeatherDetailsVerifierRobot()
        //When
        listRobot.selectLocation(city: "Dublin")
        .expandWeatherDetails()
        //Then
        verifyDetailsRobot.verifyWeatherDetailsExpanded()
    }
    
    func testDeleteSavedCity() {
        //Given
        let listRobot = WeatherListRobot();
        let verifierRobot = WeatherListVerifiierRobot();
        //When
        listRobot.deleteLocation(city: "Dublin")
        //Then
        verifierRobot.verifyLocationGone(city: "Dublin")
    }
    
    func testSearchForCityAndSave() {
        //Given
        let listRobot = WeatherListRobot();
        //When
        listRobot.selectSearch()
        .searchForLocation(query: "Sofia, Bulgaria")
        .selectLocation(location: "Sofia, Bulgaria")
        //Then
        let verifierRobot = WeatherListVerifiierRobot();
        verifierRobot.verifyLocationsVisible(cities: "Sofia")
    }
}
