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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}