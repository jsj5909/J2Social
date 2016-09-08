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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var imageAdd: CircleView!
    @IBOutlet weak var captionField: FancyField!
   
    
    var imagePicker:UIImagePickerController!
    
    static var imageCache: NSCache<NSString,UIImage> = NSCache()
    
    var imageSelected:Bool = false
    
    var posts = [Post]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // i think this is creating the problem with multiple cell repeatings
        DataService.ds.REF_POSTS.observe(.value, with:{ (snapshot) in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                
                for snap in snapshots
                {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject>
                    {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        print("JON: \(self.posts.count)")
                    }
                }
            }
            self.tableView.reloadData()
            
            })
    
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imageAdd.image = image
            imageSelected = true
        }
        else{
            print("A valid image wasnt selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       // print("JON: \(posts.count)")
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        {
            
            if let img = FeedVC.imageCache.object(forKey: post.imgURL)
            {
                cell.configureCell(post: post, img: img)
               
            }
            else
            {
                cell.configureCell(post: post)
              
            }
            return cell
        }
        else
        {
            return PostCell()
        }
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func postBTNTapped(_ sender: AnyObject)
    {
        guard let caption = captionField.text, caption != ""
        else
        {
            print("JON: Caption must be entered")
            return
        }
        
        guard let imgData = imageAdd.image, imageSelected == true
            else {
            print("JON:  An image must be selected")
            return
        }//next compress the image and put into data for upload
        if let imgData = UIImageJPEGRepresentation(imgData, 0.2)
        {
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.Ref_Post_Images.child(imgUid).put(imgData, metadata: metaData, completion: { (metaData, error) in
                if error != nil
                {
                    print("JON:  Unable to upload image to Firebase storage")
                }
                else
                {
                    print("JON:  Image uploaded to Firebase")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL
                    {
                    self.postToFirebase(imgUrl: url)
                    }
                }
            })
        }
    }
    func postToFirebase(imgUrl: String)
    {
        let post: Dictionary<String,AnyObject> = ["Caption": captionField.text!, "ImageURL": imgUrl, "Likes": 0]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        
        firebasePost.setValue(post)
        
        captionField.text = ""
        imageSelected = false
        imageAdd.image = UIImage(named: "add-image")
        
        tableView.reloadData()
    }
    
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        
        present(imagePicker, animated: true, completion: nil)
        
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
