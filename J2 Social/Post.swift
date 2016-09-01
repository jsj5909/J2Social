//
//  Post.swift
//  J2 Social
//
//  Created by Apple on 8/31/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import Foundation

class Post{
    
    private var _caption:String!
    private var _imgURL:String!
    private var _likes:Int!
    private var _postKey:String!
    
    var caption:String {
        return _caption
    }
    var imgURL:String{
        return _imgURL
    }
    var likes:Int{
        return _likes
    }
    var postKey:String{
        return _postKey
    }
    
    init (caption:String, imgURL:String, likes:Int)
    {
        self._caption = caption
        self._imgURL = imgURL
        self._likes = likes
    }
    
    init (postKey:String, postData:Dictionary<String,AnyObject>)
    {
        self._postKey = postKey
        
        if let caption = postData["Caption"] as? String
        {
            self._caption = caption
        }
        if let imgURL = postData["imageURL"] as? String
        {
            self._imgURL = imgURL
        }
        if let likes = postData["Likes"] as? Int
        {
            self._likes = likes
        }
    }
    
}
