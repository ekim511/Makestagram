//
//  StorageService.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/11/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//


import UIKit
import FirebaseStorage

struct StorageService {
    // provide method for uploading images
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1 Change the image from an UIImage to Data and reduce the quality of the image.
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        // 2 Upload our media data to the path provided as a parameter to the method
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3 check if there was an error. If there is an error, we return nil to our completion closure to signal there was an error
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // 4 If everything was successful, we return the download URL for the image.
            completion(metadata?.downloadURL())
        })
    }
}
