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
    
    var selectedPerson: Person?
    
    var person: Person? {
        didSet (newPerson) {
            print(person)
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Arrived at MapViewController")
        person = selectedPerson
    }
}