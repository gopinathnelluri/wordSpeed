//
//  User.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/21/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import Foundation
class User: NSObject, NSCoding{
    var name: String = ""
    var recent1: Int = 0
    var recent2: Int = 0
    var recent3: Int = 0
    var recentCount1: Int = 0
    var recentCount2: Int = 0
    var recentCount3: Int = 0
    var delay: Int = 1
    var top: Int  = 0
    var defaultWPM: Int = 100
    
    init(name: String) {
        self.name = name
        self.recent1 = 0
        self.recent2 = 0
        self.recent3 = 0
        self.recentCount1 = 0
        self.recentCount2 = 0
        self.recentCount3 = 0
        self.top = 0
        self.defaultWPM = 100
        self.delay = 1
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(String(recent1), forKey: "recent1")
        aCoder.encode(String(recent2), forKey: "recent2")
        aCoder.encode(String(recent3), forKey: "recent3")
        aCoder.encode(String(recentCount1), forKey: "recentCount1")
        aCoder.encode(String(recentCount2), forKey: "recentCount2")
        aCoder.encode(String(recentCount3), forKey: "recentCount3")
        aCoder.encode(String(top), forKey: "top")
        aCoder.encode(String(delay), forKey: "delay")
        aCoder.encode(String(defaultWPM), forKey: "defaultWPM")
    }
    
    required init (coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as! String
        recent1 = Int(aDecoder.decodeObject(forKey: "recent1") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recent1") as! String)!
        recent2 = Int(aDecoder.decodeObject(forKey: "recent2") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recent2") as! String)!
        recent3 = Int(aDecoder.decodeObject(forKey: "recent3") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recent3") as! String)!
        recentCount1 = Int(aDecoder.decodeObject(forKey: "recentCount1") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recentCount1") as! String)!
        recentCount2 = Int(aDecoder.decodeObject(forKey: "recentCount2") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recentCount2") as! String)!
        recentCount3 = Int(aDecoder.decodeObject(forKey: "recentCount3") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "recentCount3") as! String)!
        top = Int(aDecoder.decodeObject(forKey: "top") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "top") as! String)!
        delay = Int(aDecoder.decodeObject(forKey: "delay") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "delay") as! String)!
        defaultWPM = Int(aDecoder.decodeObject(forKey: "defaultWPM") as! String) == nil ? 0 : Int(aDecoder.decodeObject(forKey: "defaultWPM") as! String)!
    }
    
    init(name: String, defaultWPM: Int, top: Int, recent1: Int, recent2: Int, recent3: Int, delay: Int) {
        self.name = name
        self.defaultWPM = defaultWPM
        self.top = top
        self.recent1 = recent1
        self.recent2 = recent2
        self.recent3 = recent3
        self.delay = delay
    }
    
    func recent(speed: Int){
        if(recent1 != speed){
            recent3 = recent2
            recent2 = recent1
            recent1 = speed
            recentCount3 = recentCount2
            recentCount2 = recentCount1
            recentCount1 = 1
            if(speed > top){
                top = speed
            }
        } else {
            recentCount1 += 1
        }
    }
    
    func setDefaultSpeed(speed: Int){
        defaultWPM = speed
    }
    
    func getDefaultSpeed() -> Int{
        return defaultWPM
    }
    
    func setMyDelay(_ delay: Int){
        self.delay = delay
    }
    

}
