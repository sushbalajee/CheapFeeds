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

    
    @IBOutlet weak var starImages: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var urlLink: UIButton!
    @IBOutlet weak var menuLink: UIButton!
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var dataFromResults = [RestaurantData]()
    
    
//---------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainTitle.layer.shadowColor = UIColor.white.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10

        view1.layer.shadowColor = UIColor.darkGray.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 1
        
        view3.layer.shadowColor = UIColor.darkGray.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = CGSize.zero
        view3.layer.shadowRadius = 1
    
        map.layer.cornerRadius = 10
        
        for item in dataFromResults {
            
            let url = URL(string: item.mainImage!)
            
            if(!(item.mainImage!.isEmpty)){
                
                let string = url?.description
                let replaced = (string! as NSString).replacingOccurrences(of: "?output-format=webp", with: "")
                
                let Durl = URL(string: replaced)
                
                let imageView = headImage.viewWithTag(2) as! UIImageView
                
                imageView.sd_setImage(with: URL(string: (Durl?.description)!))
            
            }
            else{
                self.headImage.image = UIImage(named: "foodPasta")
            }
            
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
            addressLabel.text = ("Address: " + item.address)
            
            cuisineLabel.text = ("Cuisines: " + item.cuisines)
            averageCostLabel.text = ("Average cost: " + item.currency + item.averageCostPP.description)
            
            let doubleRating = Double(item.aggregateRating!)
            
            if (doubleRating! < 1){
                self.starImages.image = UIImage(named: "1s")
            }
            else if (doubleRating! > 1.25 && doubleRating! <= 1.75){
                self.starImages.image = UIImage(named: "1.5s")
            }
            else if (doubleRating! > 1.75 && doubleRating! <= 2.25){
                self.starImages.image = UIImage(named: "2s")
            }
            else if (doubleRating! > 2.25 && doubleRating! <= 2.75){
                self.starImages.image = UIImage(named: "2.5s")
            }
            else if (doubleRating! > 2.75 && doubleRating! <= 3.25){
                self.starImages.image = UIImage(named: "3s")
            }
            else if (doubleRating! > 3.25 && doubleRating! <= 3.75){
                self.starImages.image = UIImage(named: "3.5s")
            }
            else if (doubleRating! > 3.75 && doubleRating! <= 4.25){
                self.starImages.image = UIImage(named: "4s")
            }
            else if (doubleRating! > 4.25 && doubleRating! <= 4.75){
                self.starImages.image = UIImage(named: "4.5s")
            }
            else if (doubleRating! > 4.75 && doubleRating! <= 5){
                self.starImages.image = UIImage(named: "5s")
            }
            
        }
    }
    
//---------------------------------------------------------------------------------//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//---------------------------------------------------------------------------------//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "push menu" ){
            let DestViewController: Links_VC = segue.destination as! Links_VC
         
            for data in dataFromResults{
            DestViewController.linkString = data.menuUrl
            }
        }
        if(segue.identifier == "push zomato" ){
            let DestViewController: Links_VC = segue.destination as! Links_VC
            
            for data in dataFromResults{
                DestViewController.linkString = data.url
            }
        }
    }
}


