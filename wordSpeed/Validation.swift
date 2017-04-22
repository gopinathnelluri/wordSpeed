//
//  Validation.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/21/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import Foundation
class Validation{
    
    let set:NSCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ!@#$%^&*()_={}[];':\"\\?/~`.,<>|€£¥•+-")
    

    
    func setData(_ b : String) -> String{
        if b == "" {
            return "0"
        } else {
            return b
        }
    }
    
    func numValidate(_ b : String) -> String{
        
        if b != "" {
            var data = b.trimmingCharacters(in: set as CharacterSet).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            if data == "" || Double(data)! < 0 {
                data = ""
            }
            
            return data
        } else {
            return ""
        }
        
    }
}
