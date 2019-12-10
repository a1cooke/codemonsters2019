//
//  HighLowAttributedString.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

func highLowAttributedString(high: Double, low: Double, size: CGFloat = 15) -> NSAttributedString {
    let font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    let mstr = NSMutableAttributedString(
        string: String(format: "%.0f°", high),
        attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
    mstr.append(NSAttributedString(
        string: String(format: " %.0f°", low),
        attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor(white: 0.733333333, alpha: 1)
        ]))
    return mstr
}
