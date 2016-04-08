//
//  Location.swift
//  iOS-final
//
//  Created by M Mommersteeg on 08/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation


class Location {
    
    let latitude: Double
    let longitude: Double
    let city: String
    
    init(latitude: Double, longitude: Double, city: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
    }
}