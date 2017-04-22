//
//  UsersDB.swift
//  wordSpeed
//
//  Created by Gopinath Nelluri on 4/21/17.
//  Copyright © 2017 Gopinath Nelluri. All rights reserved.
//

import Foundation
class UsersDB{
    var users: Array<User>
    
    init ()
    {
        users = Array<User> ()
    }
    
    func userAtIndex(_ idx: Int) -> User {
        return users[idx]
    }
    
    func userInUsers(_ name: String) -> User! {
        for user in users{
            if(user.name == name){
                return user
            }
        }
        return nil
    }
    
    
    func indexOfUser(_ name: String) -> Int {
        for i in 0..<users.count{
            if(users[i].name == name){
                return i
            }
        }
        return -1
    }
    
    func deleteUserAtIndex(_ idx:Int){
        users.remove(at: idx)
        
    }
    
    func count() -> Int {
        return users.count
    }
    
    func addUser(_ u : User){
        users.append(User(name: u.name, defaultWPM: u.defaultWPM, top: u.top, recent1: u.recent1, recent2: u.recent2, recent3: u.recent3, delay: u.delay))
    }
    
    func addUser(_ name : String){
        users.append(User(name: name))
    }
    
    func updateUser(_ user: User){
        for i in 0..<users.count{
            if(users[i].name == user.name){
                users[i] = user
            }
        }
    }
    
    func archive(_ notification: Notification) {
        let path = NSHomeDirectory() + "Documents/usersNotification.archive"
        NSKeyedArchiver.archiveRootObject(users,
                                          toFile: path)
    }
    
    func archive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        
        
        NSKeyedArchiver.archiveRootObject(users, toFile: path)

    }
    
    func unarchive() {
        let path = NSHomeDirectory() + "/Documents/users.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            users = NSKeyedUnarchiver.unarchiveObject(withFile: path)
                as! [User]
        }
        
    }
    
    func unarchive(_ notification: Notification) {
        let path = NSHomeDirectory() + "/Documents/usersNotification.archive"
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            users = NSKeyedUnarchiver.unarchiveObject(withFile: path)
                as! [User]
        }
    }
    
    
    
}
