//
//  EmbeddedSection.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class EmbeddedSection {

    let identifier: NSObjectProtocol
    let items: [ListDiffable]

    init(identifier: NSObjectProtocol, items: [ListDiffable]) {
        self.identifier = identifier
        self.items = items
    }

}
