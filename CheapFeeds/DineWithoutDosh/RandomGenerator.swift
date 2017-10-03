//
//  RandomGenerator.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 3/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class RandomGenerator: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func spinButton(_ sender: Any) {
        
        /*UIView .beginAnimations(nil, context: nil)
        UIView .setAnimationDuration(0.6)
        CGAffineTransform.self transform = translatedBy(__CGAffineTransformMake(0,200)
        
        
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
        UIPickerView.transform = transfrom;
        UIPickerView.alpha = PickerView.alpha * (-1) + 1;
        [UIView commitAnimations];
        */
    }
    
    @IBOutlet weak var spinner: UIPickerView!
    
    var dataToSelectFrom = [RestaurantData]()
    
    @IBAction func generateButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.delegate = self
        spinner.dataSource = self
        
        //spinner.alpha = 0;
       // [self.view.addSubview: UIPickerView];
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return dataToSelectFrom.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataToSelectFrom[row].name
    }
}
