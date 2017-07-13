//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Eliott Kim on 7/13/17.
//  Copyright © 2017 Eliott Kim. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    static let height: CGFloat = 54
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
    }
    
    
}
