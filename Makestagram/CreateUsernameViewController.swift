//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/10/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CreateUsernameViewController : UIViewController {
    
    //MARK: Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
      
    }
    
    //MARK: IB Actions
    //create new user in database
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // 1 guard to check that a FIRUser is logged in and that the user has provided a username in the text field
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        // 2 create a dictionary to store the username the user has provided inside our database
        let userAttrs = ["username": username]
        
        // 3 specify a relative path for the location of where we want to store our data
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        // 4 write the data we want to store at the location we provided in step 3
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
            // 5 read the user we just wrote to the database and create a user from the snapshot
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                
                // handle newly created user here
            })
        }
    }
    
    
    
}
