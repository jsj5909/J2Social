//
//  PostCell.swift
//  J2 Social
//
//  Created by Apple on 8/23/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileIMG:UIImageView!
    @IBOutlet weak var userNameLBL:UILabel!
    @IBOutlet weak var postIMG:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLBL:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
