//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/12/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight : CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
