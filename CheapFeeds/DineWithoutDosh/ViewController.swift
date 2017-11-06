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

    @IBOutlet weak var textf: UITextField!
    @IBOutlet weak var cuisinePicker: UIPickerView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    
    var x = 0
    var stopTheGeo = 0

    var pickCC = [String]()

    let locationManager = CLLocationManager()
    
    var centerLatitude = -41.210930, centerLongitude = 174.906774

    var lats = CLLocationDegrees()
    var longs = CLLocationDegrees()
    var xx = 0
    var yy = 20
    var pickedCuisine = "--- Any ---"

    var filteredAnyByCost = [RestaurantData]()
    var restaurantInfo = [RestaurantData]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view1.layer.shadowColor = UIColor.darkGray.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 1
        
        view2.layer.shadowColor = UIColor.darkGray.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = CGSize.zero
        view2.layer.shadowRadius = 1
        
        view3.layer.shadowColor = UIColor.darkGray.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = CGSize.zero
        view3.layer.shadowRadius = 1
   
      locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print("working")
        }
        
        textf.addTarget(nil, action:Selector(("firstResponderAction:")), for: .editingDidEndOnExit)
  
        textf.keyboardType = UIKeyboardType.numberPad
        
        cuisinePicker.reloadAllComponents()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            lats = location.coordinate.latitude
            longs = location.coordinate.longitude
            
            while xx < 100 {
                self.uploadData(changingURL: "https://developers.zomato.com/api/v2.1/search?&lat=\(lats)&lon=\(longs)&start=\(xx)&count=\(yy)", APIHeader: "restaurants")
             xx += 20
             yy += 20
             }
            while stopTheGeo < 1 {
                self.uploadData(changingURL: "https://developers.zomato.com/api/v2.1/geocode?lat=\(lats)&lon=\(longs)", APIHeader: "nearby_restaurants")
                stopTheGeo += 1
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickCC.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let string = pickCC[row]
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickedCuisine = pickCC[row]

    }
    
    @IBAction func generate(_ sender: Any) {

        if let budget = Int(textf.text!){
            for items in restaurantInfo{
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(items.cuisines.contains(pickedCuisine)){
                        
                        let all = items
                        filteredAnyByCost.append(all)
                    }
                }
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(pickedCuisine == "--- Any ---"){
                        
                        let all = items
                        filteredAnyByCost.append(all)
                    }
                }
            }
        }
    }
    
    @IBAction func but(_ sender: Any) {
        if let budget = Int(textf.text!){
            for items in restaurantInfo{
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                    if(items.cuisines.contains(pickedCuisine)){
                        
                        let all = items
                        filteredAnyByCost.append(all)
                    }
                }
                if(items.averageCostPP <= budget && items.averageCostPP > 0){
                if(pickedCuisine == "--- Any ---"){
                    
                    let all = items
                    filteredAnyByCost.append(all)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "push to results" ){
 
        let DestViewController: FilteredResults_VC = segue.destination as! FilteredResults_VC
        
            if(textf.text == ""){
                createAlert(title: "Warning", message: "Please enter your budget")
            }
            else{
            if(filteredAnyByCost.count > 0){
                DestViewController.pulledSearch = filteredAnyByCost
            }
            else{
                createAlert(title: "Warning", message: "No results matching your budget/cuisine. Try increasing your budget!")
            }
            DestViewController.originLat = lats
            DestViewController.originLong = longs
            
            filteredAnyByCost.removeAll()
            }
        }
        
        if(segue.identifier == "push to wheel" ){
            
        let DestViewController: RandomGenerator = segue.destination as! RandomGenerator
            
            if(textf.text == "" && pickedCuisine == "--- Any ---"){
                createAlert(title: "Warning", message: "Please enter your budget")
            }
            else{
                if(filteredAnyByCost.count > 0){
                    DestViewController.dataToSelectFrom = filteredAnyByCost
                }
                else{
                    createAlert(title: "Warning", message: "No results matching your budget/cuisine. Try increasing your budget!")
                }
                filteredAnyByCost.removeAll()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createAlert(title :String, message: String){
        // create the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    

    func uploadData(changingURL: String, APIHeader: String){
        
        let zomatoKey = 

        let urlString = changingURL
        
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
                                if let restaurants = json[APIHeader] as? [NSDictionary] {
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
                                        
                                        let sepCuis = cuisines.components(separatedBy: ", ")
                                        
                                        self.pickCC.append(sepCuis[0])
                                        self.pickCC.insert("--- Any ---", at: 0 )
                                        self.pickCC = Array(Set(self.pickCC))
                                        
                                        self.pickCC = self.pickCC.sorted() { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }

                                        self.restaurantInfo.append(populate)
                                        
                                    }
                                    OperationQueue.main.addOperation {
                                        
                                        self.cuisinePicker.reloadAllComponents()
                                        
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
