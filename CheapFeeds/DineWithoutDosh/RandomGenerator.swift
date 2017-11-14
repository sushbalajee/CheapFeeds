//
//  RandomGenerator.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 3/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class RandomGenerator: UIViewController{

    @IBOutlet weak var DecidedPlace: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var spinButtonOutlet: UIButton!
    @IBOutlet weak var spinningWheel: UIImageView!
    
    var dataToSelectFrom = [RestaurantData]()
    var passOnData = [RestaurantData]()
    
    var timePassed = 0
    var timer: Timer?

    var chosenPlace = ""
    
//---------------------------------------------------------------------------------//

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
        

        if(spinButtonOutlet.titleLabel?.text == "Spin The Wheel"){
            plusButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//---------------------------------------------------------------------------------//
    
    @IBAction func spinButton(_ sender: UIButton) {
        
        if(spinButtonOutlet.titleLabel?.text == "Spin The Wheel"){
            
            passOnData.removeAll()
            plusButton.isHidden = true
            spinButtonOutlet.isHidden = true
            DecidedPlace.text = "Loading..."
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RandomGenerator.action), userInfo: nil, repeats: true)
            self.rotateView()
           
            for data in dataToSelectFrom{
                if(data.name == chosenPlace){
                    
                    let all = data
                    self.passOnData.append(all)
                }
            }
        }
    }
    
//---------------------------------------------------------------------------------//
    
    @objc func rotateView(){
        UIView.animate(withDuration: 5.0, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            
            self.spinningWheel.transform = self.spinningWheel.transform.rotated(by: CGFloat(Double.pi/1))
            
            let n = Int(arc4random_uniform(UInt32(self.dataToSelectFrom.count)))
    
            self.chosenPlace = self.dataToSelectFrom[n].name
            
        })
    }
    
//---------------------------------------------------------------------------------//
    
    @objc func action(){
        if(timePassed == 4){
            timer?.invalidate()
            timePassed = 0
            DecidedPlace.text = chosenPlace
            plusButton.isHidden = false
            spinButtonOutlet.isHidden = false
        }
        else{
        timePassed += 1
        }
    }
    
//---------------------------------------------------------------------------------//

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

            let DestViewController: DetailView_VC = segue.destination as! DetailView_VC
            DestViewController.dataFromResults = passOnData
    }
}
