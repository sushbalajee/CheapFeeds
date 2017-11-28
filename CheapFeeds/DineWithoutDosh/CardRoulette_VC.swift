//
//  CardRoulette_VC.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 8/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class CardRoulette_VC: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var arrowDown2: UIImageView!
    @IBOutlet weak var arrowDown: UIImageView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var removeButtonOutlet: UIButton!
    @IBOutlet weak var spinButtonOutlet: UIButton!
    @IBOutlet weak var spinningImage: UIImageView!
    @IBOutlet weak var tableViewPlayers: UITableView!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var mainTitle: UILabel!
    
    var timePassed = 0
    var timer: Timer?
    
    var players = [String]()
    var unlucky = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil,action: nil)
        
        let addButton = UIBarButtonItem.init(title: "Click to add player", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, addButton], animated: false)
        
        userInput.inputAccessoryView = toolBar
        
        arrowDown.isHidden = true
        arrowDown2.isHidden = true
        
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
        removeButtonOutlet.layer.cornerRadius = 10

        tableViewPlayers.delegate = self
        tableViewPlayers.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
//---------------------------------------------------------------------------------//

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height - 110
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= keyboardSize.height - 110
            }
        }
    }
    
//---------------------------------------------------------------------------------//
    
    @objc func doneClicked(){
        if(!(userInput.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
            players.append(userInput.text!)
            tableViewPlayers.reloadData()
            spinButtonOutlet.isHidden = false
            userInput.text = ""
        }
        else{
            userInput.text = ""
        }
        
        if(players.count > 6){
            arrowDown.isHidden = false
            arrowDown2.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//---------------------------------------------------------------------------------//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = players[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear
        
        let btn = UIButton(type: UIButtonType.custom) as UIButton
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("x", for: UIControlState.normal)
        btn.frame = CGRect(x: tableViewPlayers.frame.width - 20,y:1.5,width:20,height:22)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControlEvents.touchUpInside)
        btn.tag = indexPath.row
        cell.contentView.addSubview(btn)

        return cell
    }

//---------------------------------------------------------------------------------//
    
    //Button Action is
    @objc func buttonPressed(sender:UIButton!)
    {
        let buttonRow = sender.tag
        players.remove(at: buttonRow)
        tableViewPlayers.reloadData()
    }
    
//---------------------------------------------------------------------------------//
    
    @IBAction func spinButton(_ sender: Any) {
        
        if(spinButtonOutlet.titleLabel?.text == "Spin"){
            if(players.count == 1){
                createAlert(title: "Warning", message: "Enter more players")
            }
            else{
            spinButtonOutlet.isHidden = true
            mainTitle.text = "Who's Going To Pay?"
      
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RandomGenerator.action), userInfo: nil, repeats: true)
            
                self.rotateView()
                
            }
        }
    }
    
//---------------------------------------------------------------------------------//
    
    @objc func rotateView(){
        UIView.animate(withDuration: 5.0, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            self.spinningImage.transform = self.spinningImage.transform.rotated(by: CGFloat(Double.pi/1))
            
            let n = Int(arc4random_uniform(UInt32(self.players.count)))

            self.unlucky = self.players[n]
        })
    }
    
//---------------------------------------------------------------------------------//
    
    @objc func action(){
        if(timePassed == 4){
            timer?.invalidate()
            timePassed = 0
            mainTitle.text = unlucky
            spinButtonOutlet.isHidden = false
            
        }
        else{
            timePassed += 1
        }
    }
    
//---------------------------------------------------------------------------------//
    
    @IBAction func removeAllButton(_ sender: Any) {
        
        players.removeAll()
        tableViewPlayers.reloadData()
        spinButtonOutlet.isHidden = true
        arrowDown.isHidden = true
        arrowDown2.isHidden = true
        mainTitle.text = "Who's Going To Pay?"
    }
    
//---------------------------------------------------------------------------------//
    
    /* Error handling messages using pop up dialogs */
    func createAlert(title :String, message: String){
        // create the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
//---------------------------------------------------------------------------------//
    
}
