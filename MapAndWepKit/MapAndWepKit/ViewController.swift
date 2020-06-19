//
//  ViewController.swift
//  MapAndWepKit
//
//  Created by 이현욱 on 2020/06/19.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    
    func myLocation(latitude: CLLocationDegrees, longtitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        map.setRegion(locationRegion, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longtitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
    }

}

