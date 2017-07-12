//
//  MGPhotoHelper.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/11/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//
//PURPOSE:
//Presenting the popover to allow the user to choose between taking a new photo or selecting one from the photo library
//Depending on the user's selection, presenting the camera or photo library
//Returning the image that the user has taken or selected

import UIKit

class MGPhotoHelper: NSObject {
    
    // MARK: - Properties
    
    //MGPhotoHelper has a completionHandler that will be called when the user has selected a photo from UIImagePickerController
    var completionHandler: ((UIImage) -> Void)?
    
    // MARK: - Helper Methods
    
    //takes a reference to a view controller as a reference
    func presentActionSheet(from viewController: UIViewController) {
        // 1 Initialize a new UIAlertController of type actionSheet
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        
        // 2 Check if the current device has a camera available. The simulator doesn't have a camera and won't execute the if clause
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .camera, from: viewController)
            })
            
            alertController.addAction(capturePhotoAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })
            
            alertController.addAction(uploadAction)
        }
        
        // 6 Add a cancel action to allow an user to close the UIAlertController action sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 7 Present the UIAlertController from our UIViewController
        viewController.present(alertController, animated: true)
    }
    
    
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
    }
}

extension MGPhotoHelper: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completionHandler?(selectedImage)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
