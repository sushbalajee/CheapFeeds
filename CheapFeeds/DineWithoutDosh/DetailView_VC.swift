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
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var dataFromResults = [RestaurantData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mainTitle.layer.shadowColor = UIColor.white.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10

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
         
            for data in dataFromResults{
            DestViewController.linkkString = data.menuUrl
            }
        }
        if(segue.identifier == "push zomato" ){
            let DestViewController: Links_VC = segue.destination as! Links_VC
            
            for data in dataFromResults{
                DestViewController.linkkString = data.url
            }
        }
    }
}
