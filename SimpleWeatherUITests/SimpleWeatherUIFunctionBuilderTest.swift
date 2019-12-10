//
//  SimpleWeatherUIFunctionBuilderTest.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class SimpleWeatherUIFunctionBuilderTest: XCTestCase {

    func testSelectSavedCityDisplaysCorrectly() {
        
        EvolvedWeatherListRobot {
            $0.selectLocation(city: "Dublin")
            .expandWeatherDetails()
        }
        
        EvolvedWeatherDetailsVerifierRobot {
            $0.verifyWeatherDetailsExpanded()
        }
        
    }
    
}
