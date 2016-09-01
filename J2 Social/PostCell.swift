//
//  PostCell.swift
//  J2 Social
//
//  Created by Apple on 8/23/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileIMG:UIImageView!
    @IBOutlet weak var userNameLBL:UILabel!
    @IBOutlet weak var postIMG:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLBL:UILabel!
    
    var post:Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post:Post, img:UIImage? = nil)
    {
        self.post = post
        self.caption.text = post.caption
        self.likesLBL.text = "\(post.likes)"
        
        if img != nil
        {
            self.postIMG.image = img
        }
        else
        {
            
            let ref = FIRStorage.storage().reference(forURL: post.imgURL)
            
                    ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data,error) in
                        if error != nil
                        {
                           print("JON:  Unable to download image from Firebase storage")
                        }
                        else
                        {
                          print("JON: Image downloaded from firebase storage")
                            if let imgData = data
                            {
                                if let img = UIImage(data: imgData)
                                {
                                    self.postIMG.image = img
                                    FeedVC.imageCache.setObject(img, forKey: post.imgURL)
                                }
                                
                            }
                        }
                    })
        }
    }
}
        

