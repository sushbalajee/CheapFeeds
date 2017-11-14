//
//  Links_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 4/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit
import WebKit

class Links_VC: UIViewController {
    
    @IBOutlet weak var linkWebView: UIWebView!
    
    var linkString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        linkWebView.loadRequest((URLRequest(url: NSURL (string: linkString)! as URL)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
