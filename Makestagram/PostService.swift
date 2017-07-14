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
        let imageRef = StorageReference.newPostImageReference()
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
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        // 1 create references to the important locations that we're planning to write data
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        // 2 Use our class method to get an array of all of our follower UIDs
        UserService.followers(for: currentUser) { (followerUIDs) in
            // 3 construct a timeline JSON object where we store our current user's uid. We need to do this because when we fetch a timeline for a given user, we'll need the uid of the post in order to read the post from the Post subtree
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            // 4 create a mutable dictionary that will store all of the data we want to write to our database. We initialize it by writing the current timeline dictionary to our own timeline because our own uid will be excluded from our follower UIDs
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            // 5 add our post to each of our follower's timelines
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            // 6 make sure to write the post we are trying to create
            let postDict = post.dictValue
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            // 7 write our multi-location update to our database
            rootRef.updateChildValues(updatedData)
        }
    }
    
    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
}
