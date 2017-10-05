//
//  RandomGenerator.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 3/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class RandomGenerator: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pickAnimated: UIPickerView!
    @IBOutlet weak var spinButtonOutlet: UIButton!
    @IBOutlet weak var spinningWheel: UIImageView!
    
    var dataToSelectFrom = [RestaurantData]()
    var passOnData = [RestaurantData]()
    
    var timeTimer: Timer?
    var counter = 0
    var chosenPlace = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowRadius = 10
        headerView.layer.cornerRadius = 40
        
        pickAnimated.layer.shadowColor = UIColor.black.cgColor
        pickAnimated.layer.shadowOpacity = 1
        pickAnimated.layer.shadowOffset = CGSize.zero
        pickAnimated.layer.shadowRadius = 10
     
        mainTitle.layer.shadowColor = UIColor.black.cgColor
        mainTitle.layer.shadowOpacity = 1
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10
        
        spinButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        spinButtonOutlet.layer.shadowOpacity = 1
        spinButtonOutlet.layer.shadowOffset = CGSize.zero
        spinButtonOutlet.layer.shadowRadius = 10
        spinButtonOutlet.layer.cornerRadius = 10
        
        spinButtonOutlet.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        spinButtonOutlet.titleLabel?.layer.shadowOpacity = 1
        spinButtonOutlet.titleLabel?.layer.shadowOffset = CGSize.zero
        spinButtonOutlet.titleLabel?.layer.shadowRadius = 10

        pickAnimated.delegate = self
        pickAnimated.dataSource = self
        
        if(spinButtonOutlet.titleLabel?.text == "Spin The Wheel"){
            plusButton.isHidden = true
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func spinButton(_ sender: UIButton) {
        
        if(spinButtonOutlet.titleLabel?.text == "Spin The Wheel"){
            passOnData.removeAll()
            plusButton.isHidden = true
            mainTitle.text = "Where Should I Eat?"
            timeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.rotateView), userInfo: nil, repeats: true)
            self.rotateView()
            spinButtonOutlet.setTitle("Stop", for: .normal)
            
        }
        else{
            plusButton.isHidden = false
            timeTimer?.invalidate()
            spinButtonOutlet.setTitle("Spin The Wheel", for: .normal)
            mainTitle.text = chosenPlace
            
            for data in dataToSelectFrom{
                if(data.name == chosenPlace){
                    
                    let aa = data.name
                    let bb = data.averageCostPP
                    let cc = data.currency
                    let dd = data.mainImage
                    let ee = data.cuisines
                    let ff = data.url
                    let gg = data.address
                    let hh = data.city
                    let ii = data.menuUrl
                    let jj = data.name
                    let kk = data.aggregateRating
                    let lat = data.latitude
                    let long = data.longitude
                    
                    let populateForDetail = RestaurantData(id: aa, averageCostPP: bb, currency: cc, mainImage: dd, cuisines: ee, url: ff, address: gg, city: hh, latitude: lat, longitude: long, menuUrl: ii, name: jj, aggregateRating: kk)
                    
                    self.passOnData.append(populateForDetail)
                }
            }
        }
    }
    
    @objc func rotateView()
    {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            self.spinningWheel.transform = self.spinningWheel.transform.rotated(by: CGFloat(Double.pi/4))
            
            let n = Int(arc4random_uniform(UInt32(self.dataToSelectFrom.count)))
            
            self.pickAnimated.selectRow(n , inComponent: 0, animated: true)
            self.chosenPlace = self.dataToSelectFrom[n].name
            
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataToSelectFrom.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return dataToSelectFrom[row].name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

            let DestViewController: DetailView_VC = segue.destination as! DetailView_VC
            
            DestViewController.dataFromResults = passOnData

            passOnData.removeAll()
    }
}
