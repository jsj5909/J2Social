//
//  FancyButton.swift
//  J2 Social
//
//  Created by Apple on 8/17/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit

class FancyButton: UIButton {

    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        
        
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
      layer.cornerRadius = 2.0
        
        
        
    }
    
    
}
