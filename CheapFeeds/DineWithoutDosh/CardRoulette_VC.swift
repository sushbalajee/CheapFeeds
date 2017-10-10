//
//  CardRoulette_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 8/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class CardRoulette_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var removeButtonOutlet: UIButton!
    @IBOutlet weak var spinButtonOutlet: UIButton!
    @IBOutlet weak var spinningImage: UIImageView!
    @IBOutlet weak var tableViewPlayers: UITableView!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var mainTitle: UILabel!
    
    var players = [String]()
    var unlucky = ""
    var timeTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInput.addTarget(nil, action:Selector(("firstResponderAction:")), for: .editingDidEndOnExit)
        
        spinButtonOutlet.isHidden = true
        
        mainTitle.layer.shadowColor = UIColor.white.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize.zero
        mainTitle.layer.shadowRadius = 10
        
        removeButtonOutlet.layer.cornerRadius = 10
        spinButtonOutlet.layer.cornerRadius = 10

        tableViewPlayers.delegate = self
        tableViewPlayers.dataSource = self
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
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    @IBAction func spinButton(_ sender: Any) {
        
        if(spinButtonOutlet.titleLabel?.text == "Spin"){
            
            mainTitle.text = "Who's Going To Pay"
            timeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.rotateView), userInfo: nil, repeats: true)
            self.rotateView()
            spinButtonOutlet.setTitle("Stop", for: .normal)
            
        }
        else{

            timeTimer?.invalidate()
            spinButtonOutlet.setTitle("Spin", for: .normal)
            mainTitle.text = unlucky
        }
    }
    
    @objc func rotateView(){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            self.spinningImage.transform = self.spinningImage.transform.rotated(by: CGFloat(Double.pi/4))
            
            let n = Int(arc4random_uniform(UInt32(self.players.count)))

            self.unlucky = self.players[n]
        })
    }
    
    @IBAction func removeAllButton(_ sender: Any) {
        
        players.removeAll()
        tableViewPlayers.reloadData()
        spinButtonOutlet.isHidden = true
    } 
}
