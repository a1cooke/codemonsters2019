//
//  MKCoordinateRegion+Bounds.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/27/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation
import MapKit

extension MKCoordinateRegion {

    var bounds: CGRect {
        return CGRect(
            x: center.latitude - span.latitudeDelta / 2.0,
            y: center.longitude - span.longitudeDelta / 2.0,
            width: span.latitudeDelta,
            height: span.longitudeDelta
        )
    }

    // http://stackoverflow.com/a/15683034/940936
    var mapRect: MKMapRect {
        let a = MKMapPoint(CLLocationCoordinate2D(latitude: center.latitude + span.latitudeDelta / 2.0,
                                                               longitude: center.longitude - span.longitudeDelta / 2.0))
        let b = MKMapPoint(CLLocationCoordinate2D(latitude: center.latitude - span.latitudeDelta / 2.0,
                                                               longitude: center.longitude + span.longitudeDelta / 2.0))
        return MKMapRect(x: min(a.x, b.x), y: min(a.y, b.y), width: abs(a.x - b.x), height: abs(a.y - b.y))
    }

}
