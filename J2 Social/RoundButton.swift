//
//  RoundButton.swift
//  J2 Social
//
//  Created by Apple on 8/17/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit

class RoundButton: UIButton
{
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        
        
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        imageView?.contentMode = .scaleAspectFit
        
        

    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        

    }
    
    
   }
