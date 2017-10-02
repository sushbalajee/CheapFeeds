//
//  DetailView_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 2/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class DetailView_VC: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    var dataFromResults = [RestaurantData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontSize = mainTitle.font.pointSize
        mainTitle.font = UIFont(name: "Superclarendon-Bold", size: fontSize)

        for item in dataFromResults {
            mainTitle.text = item.name
            addressLabel.text = item.address
            cityLabel.text = item.city
            cuisineLabel.text = item.cuisines
            ratingLabel.text = item.aggregateRating
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
