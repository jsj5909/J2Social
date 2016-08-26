//
//  DataServices.swift
//  J2 Social
//
//  Created by Apple on 8/26/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = FIRDatabase.database().reference()



class DataService  {
    
    static let ds = DataService() //this line alone creates singleton
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("Posts")
    private var _REF_USERS = DB_BASE.child("Users")
    
    var REF_BASE: FIRDatabaseReference
        {
        return _REF_BASE
        }
    
    var REF_POSTS: FIRDatabaseReference
        {
        return _REF_POSTS
        }
    
    var REF_USERS: FIRDatabaseReference
        {
        return _REF_USERS
        }
    
    func createFirebaseDBUser(uid:String, userData:Dictionary<String,String>)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }

}
