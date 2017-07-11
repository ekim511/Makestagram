//
//  User.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/10/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    
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
    
    // 5 Create a custom setter method to set the current user (User singleton)
    static func setCurrent(_ user: User) {
        _current = user
    }
}

