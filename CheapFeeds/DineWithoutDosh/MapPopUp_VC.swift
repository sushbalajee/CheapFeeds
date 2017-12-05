//
//  MapPopUp_VC.swift
//  FindAFeed
//
//  Created by Sushant Balajee on 5/12/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPopUp_VC: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var newLats = CLLocationDegrees()
    var newLongs = CLLocationDegrees()
    
    var tacbBarController: UITabBarController?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }

    
    @IBAction func dismissPopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        
        let loc = locations.first
        
        print("got location")
        print((loc?.coordinate.latitude.description)! + " , " + (loc?.coordinate.longitude.description)!)
        locationManager.stopUpdatingLocation()
        
        let span = MKCoordinateSpanMake(3.0, 3.0)
        let region = MKCoordinateRegion(center: (loc?.coordinate)!, span: span)
        mapView.setRegion(region, animated: true)
    
       
    }
    
    @IBAction func dropPin(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.mapView)
        let locCoord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Ti"
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
        
        newLats = locCoord.latitude
        newLongs = locCoord.longitude
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: ViewController = segue.destination as! ViewController
        
        DestViewController.newLatitude = newLats
        DestViewController.newLongitude = newLongs
        DestViewController.hasNewLocation = true
        tabBarController?.selectedIndex = 0
        
        
    }
    
}
