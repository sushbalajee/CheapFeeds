//
//  MapPopUp_VC.swift
//  FindAFeed
//
//  Created by Sushant Balajee on 5/12/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class MapPopUp_VC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate{
   
   
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var googleMapsView: GMSMapView!

    var newLats = CLLocationDegrees()
    var newLongs = CLLocationDegrees()
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        
        view1.layer.shadowColor = UIColor.darkGray.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 1
        
        googleMapsView.layer.shadowColor = UIColor.darkGray.cgColor
        googleMapsView.layer.shadowOpacity = 1
        googleMapsView.layer.shadowOffset = CGSize.zero
        googleMapsView.layer.shadowRadius = 1
        googleMapsView.layer.borderColor = UIColor.lightGray.cgColor
        googleMapsView.layer.borderWidth = 1

    }
    
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapsView.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
    
        googleMapsView.clear() // clearing Pin before adding new
        let marker = GMSMarker(position: (location?.coordinate)!)
        marker.map = googleMapsView
        newLats = (location?.coordinate.latitude)!
        newLongs = (location?.coordinate.longitude)!
        
        
    }
    
    // MARK: GMSMapview Delegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.googleMapsView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        googleMapsView.clear() // clearing Pin before adding new
        let marker = GMSMarker(position: coordinate)
        marker.map = googleMapsView
        newLats = coordinate.latitude
        newLongs = coordinate.longitude
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil)
        
        googleMapsView.clear() // clearing Pin before adding new
        let marker = GMSMarker(position: place.coordinate)
        marker.map = googleMapsView
        newLats = place.coordinate.latitude
        newLongs = place.coordinate.longitude
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) 
    }

    @IBAction func openSearch(_ sender: UIBarButtonItem) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: ViewController = segue.destination as! ViewController
        
        DestViewController.newLatitude = newLats
        DestViewController.newLongitude = newLongs
        DestViewController.hasNewLocation = true
    }
}

