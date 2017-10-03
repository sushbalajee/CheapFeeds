//
//  RandomGenerator.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 3/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class RandomGenerator: UIViewController{
    
    @IBOutlet weak var spinB: UIButton!
    @IBOutlet weak var spinningWheel: UIImageView!
    
    var dataToSelectFrom = [RestaurantData]()
    
    var timer: Timer?
    var counter = 0
    
    @IBAction func spinButton(_ sender: Any) {
        self.rotateView()
        let timeTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.rotateView), userInfo: nil, repeats: true)
    }
    
    @objc func rotateView()
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.spinningWheel.transform = self.spinningWheel.transform.rotated(by: CGFloat(M_PI_4))
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   /* @IBAction func StopBtn_Pressed(_ sender: AnyObject)
    {
        timeTimer?.invalidate()
        self.RecordBtn.layer.removeAllAnimations()
    }
    */
}
