//
//  AlertsViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/26/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var alerts: [Alerts]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let descriptions: [String]? = alerts?.compactMap({ $0.title })
        textView.text = descriptions?.joined(separator: "\n")
        textView.contentOffset = .zero
    }

}
