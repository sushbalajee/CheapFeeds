//
//  CardRoulette_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 8/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class CardRoulette_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var removeButtonOutlet: UIButton!
    @IBOutlet weak var spinButtonOutlet: UIButton!
    @IBOutlet weak var spinningImage: UIImageView!
    @IBOutlet weak var tableViewPlayers: UITableView!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var mainTitle: UILabel!
    
    var tim = 0
    var timmy: Timer?
    
    var players = [String]()
    var unlucky = ""
    var timeTimer: Timer?
    
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
        
        userInput.addTarget(nil, action:Selector(("firstResponderAction:")), for: .editingDidEndOnExit)
        
        spinButtonOutlet.isHidden = true
        
        mainTitle.layer.shadowColor = UIColor.white.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10
        
        removeButtonOutlet.layer.cornerRadius = 10

        tableViewPlayers.delegate = self
        tableViewPlayers.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if(userInput.text != ""){
        players.append(userInput.text!)
        tableViewPlayers.reloadData()
        spinButtonOutlet.isHidden = false
        userInput.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = players[indexPath.row]
        //cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    @IBAction func spinButton(_ sender: Any) {
        
        if(spinButtonOutlet.titleLabel?.text == "Spin"){
            
            mainTitle.text = "Who's Going To Pay"
            //timeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.rotateView), userInfo: nil, repeats: true)
            
            timmy = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RandomGenerator.action), userInfo: nil, repeats: true)
            
            self.rotateView()
            //spinButtonOutlet.setTitle("Stop", for: .normal)
            
        }
        //else{

            //timeTimer?.invalidate()
            //spinButtonOutlet.setTitle("Spin", for: .normal)
            //mainTitle.text = unlucky
        //}
    }
    
    @objc func rotateView(){
        UIView.animate(withDuration: 5.0, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            self.spinningImage.transform = self.spinningImage.transform.rotated(by: CGFloat(Double.pi/1))
            
            let n = Int(arc4random_uniform(UInt32(self.players.count)))

            self.unlucky = self.players[n]
        })
    }
    
    @objc func action(){
        if(tim == 4){
            timmy?.invalidate()
            tim = 0
            mainTitle.text = unlucky
            spinButtonOutlet.isHidden = false
            
        }
        else{
            tim += 1
            print (tim)
        }
    }
    
    @IBAction func removeAllButton(_ sender: Any) {
        
        players.removeAll()
        tableViewPlayers.reloadData()
        spinButtonOutlet.isHidden = true
    } 
}
