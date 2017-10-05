//
//  DetailView_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 2/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailView_VC: UIViewController {

    @IBOutlet weak var urlLink: UIButton!
    @IBOutlet weak var menuLink: UIButton!
    @IBOutlet weak var detailViewMain: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var dataFromResults = [RestaurantData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitle.layer.shadowColor = UIColor.black.cgColor
        mainTitle.layer.shadowOpacity = 1
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10
        
        detailViewMain.layer.shadowColor = UIColor.black.cgColor
        detailViewMain.layer.shadowOpacity = 1
        detailViewMain.layer.shadowOffset = CGSize.zero
        detailViewMain.layer.shadowRadius = 10
        detailViewMain.layer.cornerRadius = 10
        
        locationView.layer.shadowColor = UIColor.black.cgColor
        locationView.layer.shadowOpacity = 1
        locationView.layer.shadowOffset = CGSize.zero
        locationView.layer.shadowRadius = 10
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.black.cgColor
        locationView.layer.cornerRadius = 10
        
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize.zero
        menuView.layer.shadowRadius = 10
        menuView.layer.cornerRadius = 20
        
        urlView.layer.shadowColor = UIColor.black.cgColor
        urlView.layer.shadowOpacity = 1
        urlView.layer.shadowOffset = CGSize.zero
        urlView.layer.shadowRadius = 10
        urlView.layer.cornerRadius = 20
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowRadius = 10
        headerView.layer.cornerRadius = 40
        
        map.layer.cornerRadius = 10
        
        for item in dataFromResults {
            
            let loc = CLLocationCoordinate2D(latitude: Double(item.latitude)!, longitude: Double(item.longitude)!)
            
            let span = MKCoordinateSpanMake(0.002, 0.002)
            
            let region = MKCoordinateRegion(center: loc, span: span)
            
            map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = loc
            annotation.title = item.name
            annotation.subtitle = item.cuisines
            
            map.addAnnotation(annotation)

            mainTitle.lineBreakMode = .byWordWrapping
            mainTitle.numberOfLines = 0
            mainTitle.text = item.name

            addressLabel.lineBreakMode = .byWordWrapping
            addressLabel.numberOfLines = 0
            addressLabel.text = item.address
            
            cuisineLabel.text = item.cuisines
            averageCostLabel.text = (item.currency + item.averageCostPP.description)
            ratingLabel.text = (item.aggregateRating! + "/5.0")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "push menu" ){
            let DestViewController: Links_VC = segue.destination as! Links_VC
         
            for it in dataFromResults{
            DestViewController.linkkString = it.menuUrl
            }
        }
        if(segue.identifier == "push zomato" ){
            let DestViewController: Links_VC = segue.destination as! Links_VC
            
            for it in dataFromResults{
                DestViewController.linkkString = it.url
            }
        }
    }
}
