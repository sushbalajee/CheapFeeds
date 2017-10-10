//
//  Information_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 9/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class Information_VC: UIViewController {

    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitle.layer.shadowColor = UIColor.white.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10

        mainText.text = "Find A Feed uses information from Zomato to find the 100 nearest restaurants to your location. You must enter your budget in the text field provided, while choosing a cuisine is optional. You may then either view the filtered results by pressing search or use the random generator to choose one of the filtered options for you. ***Average cost per person is an approximate price according to results from Zomato. Check the menu link or restaurant websites for accurate prices***"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
