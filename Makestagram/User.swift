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
}
