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

    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var costView: UIView!
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
    
    @IBAction func urlLink(_ sender: Any) {
        for it in dataFromResults{
            openUrl(urlStr: it.url)
        }
    }
    @IBAction func menuLink(_ sender: Any) {
        for it in dataFromResults{
            openUrl(urlStr: it.menuUrl)
        }
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    var dataFromResults = [RestaurantData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.black.cgColor
        menuView.layer.cornerRadius = 20
        urlView.layer.cornerRadius = 20
        map.layer.cornerRadius = 10
        headerView.layer.cornerRadius = 40
        locationView.layer.cornerRadius = 10
        detailViewMain.layer.cornerRadius = 10
        costView.layer.cornerRadius = 10
        rateView.layer.cornerRadius = 10
        
        let fontSize = mainTitle.font.pointSize
        mainTitle.font = UIFont(name: "KohinoorBangla-Regular", size: fontSize)

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
            
            
            
            print(loc)
            
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
