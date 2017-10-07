//
//  ViewController.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 30/09/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
  
    @IBOutlet weak var Appetight: UILabel!
    @IBOutlet weak var textf: UITextField!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var cuisinePicker: UIPickerView!

    var pickCuisine = ["Any", "African", "American", "Argentine", "Asian", "BBQ", "Bakery", "Beverages", "British", "Burger", "Cafe", "Cambodian", "Chinese", "Coffee and Tea", "Contemporary", "Continental", "Deli", "Desserts", "Dim Sum", "Drinks Only", "European", "Filipino", "Finger Food", "Fish and Chips", "French", "Fusion", "German", "Greek", "Grill", "Healthy", "Food", "Ice Cream", "Indian", "Indonesian", "International", "Irish", "Italian", "Japanese", "Juices", "Kiwi", "Korean", "Latin American", "Lebanese", "Malaysian", "Mediterranean", "Mexican", "Middle Eastern", "Mongolian", "Moroccan", "Nepalese", "North Indian", "Pacific", "Pizza", "Portuguese", "Pub Food", "Seafood", "Singaporean", "South Indian", "Spanish", "Sri Lankan", "Steak", "Street Food", "Sushi", "Taiwanese", "Thai", "Turkish", "Vietnamese"]
    
    let locationManager = CLLocationManager()
    var centerLatitude = -41.291672, centerLongitude = 174.791883
    
    var lats = Int ()
    var longs = Int ()
    var x = 0
    var xx = 0
    var yy = 20
    var pickedCuisine = "Any"

    var filteredAnyByCost = [RestaurantData]()
    var restaurantInfo = [RestaurantData]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.isNavigationBarHidden = true
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        

        //self.cuisinePicker.setValue(UIColor.white, forKey: "textColor")
        
        Appetight.layer.shadowColor = UIColor.lightGray.cgColor
        Appetight.layer.shadowOpacity = 1
        Appetight.layer.shadowOffset = CGSize.zero
        Appetight.layer.shadowRadius = 10
        
        while xx < 100 {
        self.uploadData()
           xx += 20
           yy += 20
        }
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickCuisine.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.cuisinePicker.setValue(UIColor.white, forKey: "textColor")
        return pickCuisine[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickedCuisine = pickCuisine[row]
        
    }
    
    @IBAction func generate(_ sender: Any) {
    
        lab.text = ""
        if let budget = Int(textf.text!){
            for items in restaurantInfo{
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(items.cuisines.contains(pickedCuisine)){
                        let aa = items.id
                        let bb = items.averageCostPP
                        let cc = items.currency
                        let dd = items.mainImage
                        let ee = items.cuisines
                        let ff = items.url
                        let gg = items.address
                        let hh = items.city
                        let ii = items.menuUrl
                        let jj = items.name
                        let kk = items.aggregateRating
                        let lat = items.latitude
                        let long = items.longitude
                        let phone = items.phoneNumber
                        
                        let pop = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk, phoneNumber: phone)
                        
                        filteredAnyByCost.append(pop)
                    }
                }
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(pickedCuisine == "Any"){
                        
                        let aa = items.id
                        let bb = items.averageCostPP
                        let cc = items.currency
                        let dd = items.mainImage
                        let ee = items.cuisines
                        let ff = items.url
                        let gg = items.address
                        let hh = items.city
                        let ii = items.menuUrl
                        let jj = items.name
                        let kk = items.aggregateRating
                        let lat = items.latitude
                        let long = items.longitude
                        let phone = items.phoneNumber
                        
                        let pop = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk, phoneNumber: phone)
                        
                        filteredAnyByCost.append(pop)
                        
                    }
                }
            }
            
        }
        else{
            lab.text = "Please enter a number"
        }
        
        
    }
    @IBAction func but(_ sender: Any) {
        lab.text = ""
        if let budget = Int(textf.text!){
            for items in restaurantInfo{
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(items.cuisines.contains(pickedCuisine)){
                    let aa = items.id
                        let bb = items.averageCostPP
                        let cc = items.currency
                        let dd = items.mainImage
                        let ee = items.cuisines
                        let ff = items.url
                        let gg = items.address
                        let hh = items.city
                        let ii = items.menuUrl
                        let jj = items.name
                        let kk = items.aggregateRating
                        let lat = items.latitude
                        let long = items.longitude
                        let phone = items.phoneNumber
                        
                        let pop = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk, phoneNumber: phone)
                        
                        filteredAnyByCost.append(pop)
                    }
                }
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                if(pickedCuisine == "Any"){
                    
                    let aa = items.id
                    let bb = items.averageCostPP
                    let cc = items.currency
                    let dd = items.mainImage
                    let ee = items.cuisines
                    let ff = items.url
                    let gg = items.address
                    let hh = items.city
                    let ii = items.menuUrl
                    let jj = items.name
                    let kk = items.aggregateRating
                    let lat = items.latitude
                    let long = items.longitude
                    let phone = items.phoneNumber
                    
                    let pop = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk, phoneNumber: phone)
                    
                    filteredAnyByCost.append(pop)
              
                    }
                }
            }
            
        }
        else{
            lab.text = "Please enter a number"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        if(segue.identifier == "push to results" ){
 
        let DestViewController: FilteredResults_VC = segue.destination as! FilteredResults_VC
        
            DestViewController.pulledSearch = filteredAnyByCost
            DestViewController.originLat = centerLatitude
            DestViewController.originLong = centerLongitude
            if(textf.text != "" ){
                DestViewController.didTheyType = true
                
            }
            filteredAnyByCost.removeAll()
            
            
        }
        
        if(segue.identifier == "push to wheel" ){
            
        let DestViewController: RandomGenerator = segue.destination as! RandomGenerator
            if(textf.text == "" && pickedCuisine == "Any"){
                DestViewController.dataToSelectFrom = restaurantInfo
                restaurantInfo.removeAll()
            }
            else{
                
            DestViewController.didTheyType = true
            DestViewController.dataToSelectFrom = filteredAnyByCost
                filteredAnyByCost.removeAll()
        
            }
        }
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            lats = location.coordinate.latitude.hashValue
            //print(location.coordinate.latitude)
            longs = location.coordinate.longitude.hashValue
            //print(location.coordinate.longitude)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func uploadData(){
        
        let zomatoKey = "d7aa15e105531ac1ece595a45666a3e8"
        //let centerLatitude = -41.291672, centerLongitude = 174.791883
        let urlString = "https://developers.zomato.com/api/v2.1/search?&lat=\(centerLatitude)&lon=\(centerLongitude)&start=\(xx)&count=\(yy)";
        let url = NSURL(string: urlString)
        
        if url != nil {
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(zomatoKey, forHTTPHeaderField: "user_key")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    let httpResponse = response as! HTTPURLResponse!
                    
                    if httpResponse?.statusCode == 200 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                if let restaurants = json["restaurants"] as? [NSDictionary] {
                                    for rest in restaurants {
                                        let restaurant = rest["restaurant"] as! NSDictionary
                                        let RestId = (restaurant["id"] as! String)
                                        let averageCostPP = (restaurant["average_cost_for_two"] as! Int/2)
                                        let currency = (restaurant["currency"] as! String)
                                        let mainImage = (restaurant["featured_image"] as? String)
                                        let cuisines = (restaurant["cuisines"] as! String)
                                        let restURL = (restaurant["url"] as! String)
                                        let location = restaurant["location"] as! NSDictionary
                                        let restAddress = (location["address"] as! String)
                                        let restCity = (location["city"] as! String)
                                        let latitude = (location["latitude"] as! String)
                                        let longitude = (location["longitude"] as! String)
                                        let menuLink = (restaurant["menu_url"] as! String)
                                        let name = (restaurant["name"] as! String )
                                        let phone = (restaurant["phone_numbers"] as? String)
                                        
                                        let user_rating = restaurant["user_rating"] as! NSDictionary
                                        let rating = (user_rating["aggregate_rating"] as! String)
                                        
                                        let populate = RestaurantData(id: RestId, averageCostPP: averageCostPP, currency: currency, mainImage: mainImage, cuisines: cuisines, url: restURL, address: restAddress, city: restCity, latitude: latitude, longitude: longitude, menuUrl: menuLink, name: name, aggregateRating: rating, phoneNumber: phone)
                                        
                                        self.restaurantInfo.append(populate)
                                   
                                    }
                                }
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            })
            task.resume()
    }
}
}
