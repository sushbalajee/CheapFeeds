//
//  TabBar_VC.swift
//  FindAFeed
//
//  Created by Sushant Balajee on 6/12/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class TabBar_VC: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        print("AaaaaaA")
        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let yourView = self.viewControllers![2] as! UINavigationController
        yourView.popToRootViewController(animated: false)
        
        let yourView2 = self.viewControllers![1] as! UINavigationController
        yourView2.popToRootViewController(animated: false)
        
    }
}
