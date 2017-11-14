//
//  Information_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 9/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class Information_VC: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.layer.shadowColor = UIColor.darkGray.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
