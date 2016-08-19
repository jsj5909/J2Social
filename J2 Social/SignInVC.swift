//
//  ViewController.swift
//  J2 Social
//
//  Created by Apple on 8/15/16.
//  Copyright © 2016 J2Jenkins. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    
    @IBOutlet weak var emailFLD: FancyField!
    
    @IBOutlet weak var passwordFLD: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBTNTapped(_ sender: AnyObject)
    {
        
        let faceBookLogin = FBSDKLoginManager()
        
        faceBookLogin.logIn(withReadPermissions: ["email"], from: self) {(result,error) in
        
            if error != nil
            {
                print("JON: unable to facebook authenticate - \(error)")
            }
            else if result?.isCancelled == true
            {
                print("JON:  User cancelled FB Auth")
            }
            else
            {
                print("JON:  FB succesfully authenticated")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
        func firebaseAuth(_ credential:FIRAuthCredential)
        {
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                
                if error != nil{
                    print("JON: unable to auth firebase \(error)")
                }
                else
                {
                    print("JON:  succesfully auth with firebase")
                }
                
            })
        }
        
    @IBAction func signInTapped(_ sender: AnyObject) {
    
        if let email = emailFLD.text, let password = passwordFLD.text
        {
          FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil
            {
                print("JON:  User authenticated with Firebase using email")
            }
            else
            {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil
                    {
                        print("JON:  Unable to authenticate user with firebase using email - Create")
                    }
                    else
                    {
                        print("JON:  User authenticated with Firebase using email - created")
                    }
                })
            }
          })
        }
    }
    

}



