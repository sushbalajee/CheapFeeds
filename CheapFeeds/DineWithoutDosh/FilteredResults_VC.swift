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
    var favourites = [RestaurantData]()
    
    var locationOrigin = CLLocation()
    var locationDest = CLLocation()
    
    var originLat = Double()
    var originLong = Double()
    
    var addedToFavs = false
    var passOnTitle = ""
    var passOnImageLink = ""
    
    @IBAction func addToFavs(_ sender: UIButton) {
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.resultsTableView)
        let indexPath = self.resultsTableView.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            if favourites.contains(where: { $0.id == pulledSearch[(indexPath?.row)!].id}) {
                print("Already Here")
            }
            else{
            favourites.append(pulledSearch[(indexPath?.row)!])
            addedToFavs = true
            }
            
            if(addedToFavs == true){
                sender.setImage(UIImage(named:"icons8-checked-48.png"), for: .normal)
            }
            
            for items in favourites{
                print(items.name)
            }
    }
}
    
//---------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.backgroundColor = UIColor.clear
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.rowHeight = (100.00)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//---------------------------------------------------------------------------------//
    
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

        cell.backgroundColor = UIColor.clear
        cell.restLabel.text = pulledSearch[indexPath.row].name
        cell.costLabel.text = ("Average price: " + pulledSearch[indexPath.row].currency +  pulledSearch[indexPath.row].averageCostPP.description)
        
        let url = URL(string: pulledSearch[indexPath.row].mainImage!)

        if(!(pulledSearch[indexPath.row].mainImage?.isEmpty)!){
            
            let string = url?.description
            let replaced = (string! as NSString).replacingOccurrences(of: "?output-format=webp", with: "")
            
            let Durl = URL(string: replaced)
            
            let imageView = cell.viewWithTag(1) as! UIImageView
            
            imageView.sd_setImage(with: URL(string: (Durl?.description)!))
           
        }
        else{
            cell.featureImage.image = UIImage(named: "foodPasta")
        }
        
        cell.featureImage.layer.borderColor = UIColor.white.cgColor
        cell.featureImage.layer.borderWidth = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let all = pulledSearch[indexPath.row]
   
        passOnData.append(all)
        self.performSegue(withIdentifier: "push to detail view", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
 
//---------------------------------------------------------------------------------//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: DetailView_VC = segue.destination as! DetailView_VC
        
        DestViewController.dataFromResults = passOnData
        passOnData.removeAll()
        
    }
}
