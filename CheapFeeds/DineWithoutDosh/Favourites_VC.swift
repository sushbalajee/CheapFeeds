//
//  Favourites_VC.swift
//  FindAFeed
//
//  Created by Sushant Balajee on 21/11/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Favourites_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favsTableView: UITableView!
    
    var favourites = [RestaurantData]()
    var passOnDataFromFavs = [RestaurantData]()
    
//---------------------------------------------------------------------------------//
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)

        favourites.removeAll()
        favsTableView.dataSource = self
        favsTableView.delegate = self
        favsTableView.rowHeight = (290.00)
        favsTableView.reloadData()
        
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
                    let favAverageCostPP = result.value(forKey: "favAverageCostPP") as! Int
                    let favCurrency = result.value(forKey: "favCurrency") as! String
                    let favMainImage = result.value(forKey: "favMainImage") as? String
                    let favCuisines = result.value(forKey: "favCuisines") as! String
                    let favUrl = result.value(forKey: "favUrl") as! String
                    let favAddress = result.value(forKey: "favAddress") as! String
                    let favCity = result.value(forKey: "favCity") as! String
                    let favLatitude = result.value(forKey: "favLatitude") as! String
                    let favLongitude = result.value(forKey: "favLongitude") as! String
                    let favMenuUrl = result.value(forKey: "favMenuUrl") as! String
                    let favName = result.value(forKey: "favName") as! String
                    let favRating = result.value(forKey: "favRating") as! String
                    let favPhone = result.value(forKey: "favPhone") as? String
   
                    let populate = RestaurantData(id: favId, averageCostPP: favAverageCostPP, currency: favCurrency, mainImage: favMainImage, cuisines: favCuisines, url: favUrl, address: favAddress, city: favCity, latitude: favLatitude, longitude: favLongitude, menuUrl: favMenuUrl, name: favName, aggregateRating: favRating, phoneNumber: favPhone)
                    
                        favourites.append(populate)
                        favsTableView.reloadData()
                    
                }
            }
        }
        catch{
            //error
        }

    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favsTableView.dequeueReusableCell(withIdentifier: "cellB", for: indexPath) as! favouritesTableViewCell
        
        cell.restLabel.text = favourites[indexPath.row].name
        cell.costLabel.text = ("Average price: " + favourites[indexPath.row].currency +  favourites[indexPath.row].averageCostPP.description)
        
        let url = URL(string: favourites[indexPath.row].mainImage!)
        
        if(!(favourites[indexPath.row].mainImage?.isEmpty)!){
            
            let string = url?.description
            let replaced = (string! as NSString).replacingOccurrences(of: "?output-format=webp", with: "")
            
            let Durl = URL(string: replaced)
            
            let imageView = cell.viewWithTag(2) as! UIImageView
            
            imageView.sd_setImage(with: URL(string: (Durl?.description)!))
            
        }
        else{
            cell.featureImage.image = UIImage(named: "foodPasta")
        }
        
        cell.featureImage.layer.borderColor = UIColor.white.cgColor
        cell.featureImage.layer.borderWidth = 10
        
        return cell
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
         
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavEntity")
            
            request.returnsObjectsAsFaults = false
            favourites.remove(at: indexPath.row)
            do
            {
                let results = try context.fetch(request)
             
                    context.delete(results[indexPath.row] as! NSManagedObject)
                    do{
                        try context.save()
                        tableView.reloadData()
                    }
                    catch{
                        //error
                    }
            }
            catch{
                //error
            }
        }
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let all = favourites[indexPath.row]
        
        passOnDataFromFavs.append(all)
        self.performSegue(withIdentifier: "push from favourites", sender: self)
    }
    
//---------------------------------------------------------------------------------//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: DetailView_VC = segue.destination as! DetailView_VC
        
        DestViewController.dataFromResults = passOnDataFromFavs
        passOnDataFromFavs.removeAll()
        
    }
}
