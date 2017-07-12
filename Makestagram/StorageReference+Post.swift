//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/12/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import FirebaseStorage


//create an extension to StorageReference with a class method that will generate a new location for each new post image that is created by the current ISO timestamp

extension StorageReference {
    static let dataFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dataFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
