//
//  MapViewController.swift
//  iOS-Final
//
//  Created by M Mommersteeg on 10/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView?
    
    let regionRadius: CLLocationDistance = 500
    
    var initialLocation: CLLocation?
    var selectedPerson: Person?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Arrived at MapViewController")
        if let p = selectedPerson {
            initialLocation = CLLocation(latitude: p.currentLocation.latitude, longitude: p.currentLocation.longitude)
            centerMapOnLocation(initialLocation!)
            
            let marker = Marker(
                title: p.getFullName(),
                locationName: p.currentLocation.city,
                discipline: Config.personDiscipline,
                coordinate: CLLocationCoordinate2D(latitude: p.currentLocation.latitude, longitude: p.currentLocation.longitude))
            
            addMarkerToMap(marker)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func addMarkerToMap(marker: Marker) {
        mapView?.addAnnotation(marker)
    }
}