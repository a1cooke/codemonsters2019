//
//  ForecastHourlyDataSource.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class ForecastHourlyDataSource: EmbeddedAdapterDataSource {

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ForecastHourCellViewModel {
            return HourlyForecastSectionController()
        }
        return ListSectionController()
    }

}
