//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/11/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let photoHelper = MGPhotoHelper()
    
    //MARK : - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
        
        //Closure : a function without a name.
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
            print("image uploaded")
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // present photo taking action sheet
            photoHelper.presentActionSheet(from: self)
            return false
        } else {
            return true
        }
    }
}

