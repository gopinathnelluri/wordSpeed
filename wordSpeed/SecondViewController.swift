//
//  SecondViewController.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/19/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var users: UsersDB!
    var user: User!
    var currentUser: String = ""
    
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.delegate = self
        self.table.dataSource = self
        

        if defaults.string(forKey: "currentUser") != nil && defaults.string(forKey: "currentUser")! != ""{
            
            currentUser = defaults.string(forKey: "currentUser")!
            defaults.synchronize()
            
            
        } else{
            unarchiveUser()
        }
        
        fetchData()
        table.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        table.reloadData()
    }
    */
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Leader Board"
        } else {
            return "My Stats"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return users.count()
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactIdentifier = "dataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: contactIdentifier, for: indexPath)
        if(indexPath.section == 1){
            let rowUser = users.userAtIndex(indexPath.row)
            cell.textLabel!.text! = rowUser.name
            cell.detailTextLabel!.text = String(rowUser.top)
            //cell.imageView!.image = UIImage(named: "/Users/nellurig/Desktop/gopi.jpg")
            return cell
        } else {
            if (indexPath.row == 1){
                cell.textLabel!.text! = "Recent Speed #2 : \(user.recent2) WPM"
                cell.detailTextLabel!.text = "\(user.recentCount2) Times"
                return cell
            } else if (indexPath.row == 2){
                cell.textLabel!.text! = "Recent Speed #3 : \(user.recent3) WPM"
                cell.detailTextLabel!.text = "\(user.recentCount3) Times"
                return cell
            } else {
                cell.textLabel!.text! = "Recent Speed #1 : \(user.recent1) WPM"
                cell.detailTextLabel!.text = "\(user.recentCount1) Times"
                return cell
            }
        }
    }
    
    func fetchData(){
        users = nil
        users = UsersDB()
        users.unarchive()
        if users.indexOfUser(currentUser) == -1{
            users.addUser(currentUser)
            print("no user")
        }
        
        print("start test in 2")
        print(users.users[0].recent1)
        print(users.users[0].recent2)
        print(users.users[0].recent3)
        
        user = users.userInUsers(currentUser)
        users.users.sort(by: {$0.top > $1.top})
        table.reloadData()
    }
    
    
    
    func unarchiveUser() {
        let path = NSHomeDirectory() + "/Documents/currentUser.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            let user = NSKeyedUnarchiver.unarchiveObject(withFile: path)
                as! String
            if user != "" {
                currentUser = user
                
            }
        }
    }

    
    func unarchive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            users.users = NSKeyedUnarchiver.unarchiveObject(withFile: path)
                as! [User]
        }
        
    }
}

