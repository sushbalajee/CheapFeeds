//
//  FilteredResults_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 1/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import CoreLocation
class FilteredResults_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var resultsTableView: UITableView!
    
    var pulledSearch = [RestaurantData]()
    var passOnData = [RestaurantData]()
    
    var locationOrigin = CLLocation()
    var locationDest = CLLocation()
    
    var originLat = Double()
    var originLong = Double()
    
    var passOnTitle = ""
    var passOnImageLink = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(pulledSearch.count)
        print(originLat.description + " " + originLong.description )
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.rowHeight = (100.00)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulledSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! resultsTableViewCell
        
        let coordinate₀ = CLLocation(latitude: originLat, longitude: originLong)
        let coordinate₁ = CLLocation(latitude: Double(pulledSearch[indexPath.row].latitude)!, longitude: Double(pulledSearch[indexPath.row].longitude)!)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        
        if(distanceInMeters > 1000){
            let dist = Double(round(100*(distanceInMeters/1000))/100)
            cell.distLabel.text = ("Approximately " + dist.description + "km away")
        }
        else{
            let dist = Double(round(distanceInMeters))
            cell.distLabel.text = ("Approximately " + dist.description + "m away")
        }

        cell.restLabel.text = pulledSearch[indexPath.row].name
        
        cell.costLabel.text = ("Average price of a meal: " + pulledSearch[indexPath.row].currency +  pulledSearch[indexPath.row].averageCostPP.description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aa = pulledSearch[indexPath.row].id
        let bb = pulledSearch[indexPath.row].averageCostPP
        let cc = pulledSearch[indexPath.row].currency
        let dd = pulledSearch[indexPath.row].mainImage
        let ee = pulledSearch[indexPath.row].cuisines
        let ff = pulledSearch[indexPath.row].url
        let gg = pulledSearch[indexPath.row].address
        let hh = pulledSearch[indexPath.row].city
        let ii = pulledSearch[indexPath.row].menuUrl
        let jj = pulledSearch[indexPath.row].name
        let kk = pulledSearch[indexPath.row].aggregateRating
        let lat = pulledSearch[indexPath.row].latitude
        let long = pulledSearch[indexPath.row].longitude
        
        let populateForDetail = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk)
        
        passOnData.append(populateForDetail)
        self.performSegue(withIdentifier: "push to detail view", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: DetailView_VC = segue.destination as! DetailView_VC
        
        DestViewController.dataFromResults = passOnData
        passOnData.removeAll()
        
    }
    
}
