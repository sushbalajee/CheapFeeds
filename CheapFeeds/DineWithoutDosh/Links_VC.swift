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

    @IBOutlet weak var linkWebView: WKWebView!
    
    var linkkString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        linkWebView.load(URLRequest(url: NSURL (string: linkkString)! as URL))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
