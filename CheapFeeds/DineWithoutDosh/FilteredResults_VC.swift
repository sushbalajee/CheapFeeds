//
//  FilteredResults_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 1/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

@available(iOS 10.0, *)
class FilteredResults_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var resultsTableView: UITableView!
    
    var pulledSearch = [RestaurantData]()
    var passOnData = [RestaurantData]()
    var favourites = [RestaurantData]()
    var checkFavs = [String]()
    
    var locationOrigin = CLLocation()
    var locationDest = CLLocation()
    
    var originLat = Double()
    var originLong = Double()
    
    var addedToFavs = false
    var passOnTitle = ""
    var passOnImageLink = ""
    
//---------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableView.backgroundColor = UIColor.clear
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.rowHeight = (100.00)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavEntity")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]
                {
                    let favId = result.value(forKey: "favId") as! String
                    
                    checkFavs.append(favId)
                }
            }
        }
        catch{
            //error
    }
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(pulledSearch.count > 0){
            return pulledSearch.count
        }
        else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! resultsTableViewCell
        if (!pulledSearch.isEmpty){
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
            
        }else{
            
        }
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
    
//---------------------------------------------------------------------------------//
}
