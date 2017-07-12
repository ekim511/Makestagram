//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/11/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import Foundation
import UIKit

//Our enum contains a case for each of our app's storyboards. We also create a computed variable that capitalizes the rawValue of each case. This computed variable returns the corresponding filename for each storyboard.
extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    // initialize the correct storyboard based each enum case
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
