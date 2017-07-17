//
//  DatabaseReference+Location.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/14/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    enum MGLocation {
        // insert cases to read/write to locations in Firebase
        
        case root
        
        func asDatabaseReference() -> DatabaseReference {
            let root = Database.database().reference()
            
            switch self {
            case .root:
                return root
            case .posts(let uid):
                return root.child("posts").child(uid)
            }
            
        }
        
        case posts(uid: String)
    }
}
