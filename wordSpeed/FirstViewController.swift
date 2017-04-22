//
//  FirstViewController.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/19/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {


    
    var user: User!
    var users: UsersDB!
    
    
    let vd = Validation()
    
    var timer = Timer()
    var counter = 0
    var timeInterval = 1.0
    var firsttime = true
    var firstTimeDelay: Int = 0
    
    var WPM : Int = 600 {
        willSet {
            timeInterval = (60.0)/Double(newValue)
        }
        didSet {
            
        }
    }
    
    var wordList : [String] = [String]()
    
    var filemanager:FileManager!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var word: UILabel!
    
    @IBOutlet weak var wpmSpeed: UITextField!
    
    
    @IBAction func wpmEditingChanged(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
        firsttime = true
    }
    
    @IBAction func wpmChanged(_ sender: UITextField) {
        sender.text! = vd.numValidate(sender.text!)
        sender.text! = vd.setData(sender.text!)
        WPM = Int(sender.text!)!

        button.setImage(UIImage(named: "Play-25"), for: .normal)
        
        if(timer.isValid){
            timer.invalidate()
            
        }
        
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        wpmSpeed.resignFirstResponder()
        if sender.currentImage! == UIImage(named: "Play-25") {
            sender.setImage(UIImage(named: "Pause-25"), for: .normal)
            if firsttime {
                sleep(UInt32(firstTimeDelay))
                firsttime = false
            }
            timer =
                Timer.scheduledTimer(
                    timeInterval: timeInterval, target:self,
                    selector: #selector(FirstViewController.updateCounter),
                    userInfo: nil, repeats: true)
            
            RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
            timer.fire()
            user.recent(speed: WPM)
        } else {
            sender.setImage(UIImage(named: "Play-25"), for: .normal)
            timer.invalidate()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wpmSpeed.delegate = self
        userName.text = defaults.string(forKey: "currentUser")
        
        filemanager = FileManager.default
        
        readFile()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        users.updateUser(user)
        users.archive()
    }
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.wpmSpeed {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        wpmSpeed.resignFirstResponder()
        self.view.endEditing(true)
    }
    

    
    func fetchData(){
        users = nil
        users = UsersDB()
        users.unarchive()
        if users.indexOfUser(userName.text!) == -1{
            users.addUser(userName.text!)
            print("------NO USER------")
        }
        
        
        
        user = users.userInUsers(userName.text!)
        WPM = user.defaultWPM
        wpmSpeed.text! = String(WPM)
        firstTimeDelay = user.delay
        firsttime = true
        
    }
    
    
    func readFile(){
        let path = Bundle.main.path(forResource: "text", ofType: "txt")!
            //NSHomeDirectory() + "/Documents/text.txt"
        
        
        if filemanager.fileExists(atPath: path) {
            if let text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8){
                let lines = text.components(separatedBy: "\n")
           
                wordList = lines[Int(arc4random_uniform(UInt32(lines.count)))].components(separatedBy: " ")
                
            }else {
                print("Error Reading file")
            }
            
        }else{
            print("error opening file for read")
        }
        
        
    }
    
    func updateCounter() {

        if 0 <= counter && counter < wordList.count{
            
            let myMutableString = NSMutableAttributedString(
                string: wordList[counter],
                attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)])
            
            myMutableString.addAttribute( NSForegroundColorAttributeName, value: UIColor.red, range: NSRange( location: (wordList[counter].characters.count)/2,length:1))
            
            word.attributedText =  myMutableString
            counter += 1
        } else {
            button.setImage(UIImage(named: "Play-25"), for: .normal)
            timer.invalidate()
            counter = 0
            readFile()
        }
    }

    
    func archive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        NSKeyedArchiver.archiveRootObject(users.users, toFile: path)
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

