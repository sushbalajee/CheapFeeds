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
    
    @IBAction func addToFavs(_ sender: UIButton) {
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.resultsTableView)
        let indexPath = self.resultsTableView.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            if checkFavs.contains(pulledSearch[(indexPath?.row)!].id){
                 createAlert(title: "Alert", message: "This restaurant is already in your favourites")
            }
            else{
            favourites.append(pulledSearch[(indexPath?.row)!])
            addedToFavs = true
                //coreData stuff
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let newFav = NSEntityDescription.insertNewObject(forEntityName: "FavEntity", into: context)
        
                newFav.setValue(pulledSearch[(indexPath?.row)!].name, forKey: "favName")
                newFav.setValue(pulledSearch[(indexPath?.row)!].address, forKey: "favAddress")
                newFav.setValue(pulledSearch[(indexPath?.row)!].aggregateRating, forKey: "favRating")
                newFav.setValue(pulledSearch[(indexPath?.row)!].averageCostPP, forKey: "favAverageCostPP")
                newFav.setValue(pulledSearch[(indexPath?.row)!].city, forKey: "favCity")
                newFav.setValue(pulledSearch[(indexPath?.row)!].cuisines, forKey: "favCuisines")
                newFav.setValue(pulledSearch[(indexPath?.row)!].currency, forKey: "favCurrency")
                newFav.setValue(pulledSearch[(indexPath?.row)!].id, forKey: "favId")
                newFav.setValue(pulledSearch[(indexPath?.row)!].latitude, forKey: "favLatitude")
                newFav.setValue(pulledSearch[(indexPath?.row)!].longitude, forKey: "favLongitude")
                newFav.setValue(pulledSearch[(indexPath?.row)!].mainImage, forKey: "favMainImage")
                newFav.setValue(pulledSearch[(indexPath?.row)!].menuUrl, forKey: "favMenuUrl")
                newFav.setValue(pulledSearch[(indexPath?.row)!].url, forKey: "favUrl")
                newFav.setValue(pulledSearch[(indexPath?.row)!].phoneNumber, forKey: "favPhone")
                
                do{
                    try context.save()
                    print("Saved")
                }
                catch{
                    //Error
                }
            }
            
            for items in favourites{
                print(items.name)
            }
    }
}
    
//---------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.deleteAllData(entity: "FavEntity")
        
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
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavEntity")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]
            {
                let managedObjectData:NSManagedObject = result
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
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
    
    /* Error handling messages using pop up dialogs */
    func createAlert(title :String, message: String){
        // create the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //---------------------------------------------------------------------------------//
}
