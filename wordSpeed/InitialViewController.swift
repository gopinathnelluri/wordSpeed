//
//  InitialViewController.swift
//  wordSpeed
//
//  Created by  on 4/20/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var currentUser = "gopinath"
    
    let defaults = UserDefaults.standard
    defaults.setValue(currentUser,forkey : "currentUser")
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
