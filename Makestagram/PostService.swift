//
//  PostService.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/11/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    //private b/c don't want to allow access to this class method from anywhere except our previous PostService.create(for:) method. create new post (JSON object) in database
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        // 1 Create a reference to the current user (UID)
        let currentUser = User.current
        
        // 2 Initialize a new Post using the data passed in by the parameters
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        // 3 Convert the new post object into a dictionary so that it can be written as JSON in our database
        let dict = post.dictValue
        
        // 4 Construct the relative path to the location where we want to store the new post data
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        
        //5 Write the data to the specified location
        postRef.updateChildValues(dict)
        
    }
    
}
