//
//  CircleView.swift
//  J2 Social
//
//  Created by Apple on 8/23/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    
    override func layoutSubviews() {
       
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
