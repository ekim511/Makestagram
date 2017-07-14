//
//  User.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/10/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User : NSObject {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    var isFollowed = false
    
    // MARK: - Init
    
    //Default Initializer
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    //Failable Initializer: guard by requiring the snapshot to be casted to a dictionary and checking that the dictionary contains username key/value. If either of these requirements fail, we return nil. Note that we also store the key property of DataSnapshot which is the UID that correlates with the user being initialized
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        super.init()
    }
    
    //Allows users to be decoded from data
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    // MARK: - Singleton
    
    // 1 Create a private static variable to hold our current user. This method is private so it can't be access outside of this class
    private static var _current: User?
    
    // 2 Create a computed variable that only has a getter that can access the private _current variable
    static var current: User {
        // 3 Check that _current that is of type User? isn't nil. If _current is nil, and current is being read, the guard statement will crash with fatalError()
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4 If _current isn't nil, it will be returned to the user
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 1 add another parameter that takes a Bool on whether the user should be written to UserDefaults
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2 check if the boolean value for writeToUserDefaults is true. If so, we write the user object to UserDefaults
        if writeToUserDefaults {
            // 3 use NSKeyedArchiver to turn our user object into Data
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // 4 store the data for our current user with the correct key in UserDefaults
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}



