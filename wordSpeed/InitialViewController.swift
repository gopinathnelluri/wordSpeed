//
//  InitialViewController.swift
//  wordSpeed
//
//  Created by  on 4/20/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    
    
    
    let defaults = UserDefaults.standard
    

    var users:UsersDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //defaults.synchronize()
        self.userName.delegate = self

        if defaults.string(forKey: "currentUser") != nil && defaults.string(forKey: "currentUser")! != ""{
            
            userName.text = defaults.string(forKey: "currentUser")
            defaults.synchronize()
            
            performSegue(withIdentifier: "userProfile", sender: self)
        } else{
            unarchiveUser()
        }
        
        defaults.setValue(userName.text!, forKey: "currentUser")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "userProfile" {
            if let currentUser = userName.text {
                print(currentUser)
                if currentUser == "" {
                    return false
                } else {
                    
                    defaults.synchronize()
                    archiveUser()
                    userProfile()

                    
                    return true
                }
            } else {
                
                return false
            }
        } else {
            return false
        }

    }
    

    func archiveUser(_ notification: Notification) {
        let path = NSHomeDirectory() + "Documents/currentUserNotification.archive"
        NSKeyedArchiver.archiveRootObject(userName.text!,
                                          toFile: path)
    }
    
    func archiveUser() {
        let path = NSHomeDirectory() + "/Documents/currentUser.archive"
        
        print(path)
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
    
    func userProfile(){
        
        users = UsersDB()
        users.unarchive()
        if users.indexOfUser(userName.text!) == -1{
            print("help me")
            users.addUser(userName.text!)
            users.archive()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userName {
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userName.resignFirstResponder()
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func switchUser(segue: UIStoryboardSegue) {
        if segue.identifier == "SwitchUserUnwindSegue" {
            
            
        } else {
            
        }
    }
    
}
