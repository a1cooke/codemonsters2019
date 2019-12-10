//
//  SavedLocation+Geocoding.swift
//  SimpleWeather
//
//  Created by Alan Cooke on 02/12/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation
import CoreLocation

extension SavedLocation {
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        let locationManager = CLLocationManager()
        if let lastLocation = locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
}
