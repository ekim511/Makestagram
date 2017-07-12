//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/7/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController : UIViewController {
    
    //MARK: Properties
   
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: VC Lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }
    //MARK: IB Actions

    @IBAction func loginButtonTapped(_ sender: Any) {
        //1 access the FUIAuth default auth UI singleton
        guard let authUI = FUIAuth.defaultAuthUI()
            else {
                return
        }
        
        //2 set FUIAuth's singleton delegate
        authUI.delegate = self
        
        //3 present the auth view controller
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

//implement FUIAuthDelegate protocol. Without this, you get a compiler error from step 2 bc LoginViewController hasn't conformed to the FUIAuthDelegate protocol.
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        // 1 First we check that the FIRUser returned from authentication is not nil by unwrapping it. We guard this statement, because we cannot proceed further if the user is nil. We need the FIRUser object's uid property to build the relative path for the user at /users/#{uid}
        guard let user = user
            else { return }
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
    
}





