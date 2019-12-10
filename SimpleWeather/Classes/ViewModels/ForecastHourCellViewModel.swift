//
//  ForecastHourCellViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

class ForecastHourCellViewModel {

    static private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "h a"
        return df
    }()

    let date: Date
    let temp: Double
    let conditionImageName: String
    let chancePrecip: Double

    init(date: Date, temp: Double, conditionImageName: String, chancePrecip: Double) {
        self.date = date
        self.temp = temp
        self.conditionImageName = conditionImageName
        self.chancePrecip = chancePrecip
    }

    var dateString: String {
        return ForecastHourCellViewModel.dateFormatter.string(from: date)
    }

    var detailsAttributedString: NSAttributedString {
        let fontSize: CGFloat = 15
        let mAttrString = NSMutableAttributedString(
            string: String(format: "%.0f°", temp),
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)]
        )
        if chancePrecip >= 0.2 {
            let percipAttrStr = NSAttributedString(
                string: String(format: " %.0f%%", round(chancePrecip * 10.0) * 10.0),
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light),
                    NSAttributedString.Key.foregroundColor: UIColor(red: 73/255.0, green: 130/255.0, blue: 193/255.0, alpha: 1)
                ]
            )
            mAttrString.append(percipAttrStr)
        }
        return mAttrString
    }

}
