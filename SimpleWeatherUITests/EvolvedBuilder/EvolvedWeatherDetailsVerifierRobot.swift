//
//  EvolvedWeatherDetailsVerifierRobot.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest

class EvolvedWeatherDetailsVerifierRobot {
    
    @ConstructionWrapper
    private var application: XCUIApplication
    
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

extension EvolvedWeatherDetailsVerifierRobot {
    convenience init(_ closure: (EvolvedWeatherDetailsVerifierRobot) -> Void) {
        self.init()
        closure(self)
    }
}
