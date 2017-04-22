//
//  ThirdViewController.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/19/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    var vd = Validation()
    
    var user: User!
    var users: UsersDB!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var defaultSpeed: UITextField!
    
    @IBOutlet weak var startDelay: UITextField!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBAction func speedEnd(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
        sender.text! = vd.setData(sender.text!)
        user.defaultWPM = Int(sender.text!)!
    }
    @IBAction func speedChange(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
    }
    
    @IBAction func delayEnd(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
        sender.text! = vd.setData(sender.text!)
        user.delay = Int(sender.text!)!
    }
    
    @IBAction func delayChanage(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultSpeed.delegate = self
        self.startDelay.delegate = self
        

        if defaults.string(forKey: "currentUser") != nil && defaults.string(forKey: "currentUser")! != ""{
            
            userName.text = defaults.string(forKey: "currentUser")
            defaults.synchronize()
            
        } else{
            unarchiveUser()
        }
        fetchData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        users.updateUser(user)
        users.archive()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.defaultSpeed {
            startDelay.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultSpeed.resignFirstResponder()
        startDelay.resignFirstResponder()
        self.view.endEditing(true)
    }

    
    func archiveUser() {
        let path = NSHomeDirectory() + "/Documents/currentUser.archive"

        NSKeyedArchiver.archiveRootObject(userName.text!, toFile: path)
        defaults.setValue(userName.text!, forKey: "currentUser")
        defaults.synchronize()
    }
    
    func unarchiveUser() {
        let path = NSHomeDirectory() + "/Documents/currentUser.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            let user = NSKeyedUnarchiver.unarchiveObject(withFile: path)
                as! String
            if user != "" {
                userName.text! = user
                
            }
        }
    }
    
    
    
    func fetchData(){
        users = UsersDB()
        users.unarchive()
        if users.indexOfUser(userName.text!) == -1{
            users.addUser(userName.text!)
            print("------NO USER------")
        }
        
        
        
        user = users.userInUsers(userName.text!)
        defaultSpeed.text! = String(user.defaultWPM)
        startDelay.text! = String(user.delay)
        
    }

    
}
