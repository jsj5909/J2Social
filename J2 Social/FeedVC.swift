//
//  FeedVC.swift
//  J2 Social
//
//  Created by Apple on 8/19/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutTapped(_ sender: AnyObject) {
        
       let keychainResult =  KeychainWrapper.removeObjectForKey(KEY_UID)
        
        print("JON: Signout \(keychainResult)")
        
        try! FIRAuth.auth()?.signOut()
        
        performSegue(withIdentifier: "GoToSignIn", sender: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
