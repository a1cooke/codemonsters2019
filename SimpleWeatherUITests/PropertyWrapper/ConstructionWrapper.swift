//
//  ConstructionWrapper.swift
//  SimpleWeatherUITests
//
//  Created by Alan Cooke on 11/20/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@propertyWrapper
struct ConstructionWrapper<Value: XCUIApplication> {
    
    var wrappedValue: Value
    
    init() {
        wrappedValue = Value()
    }
    
}
