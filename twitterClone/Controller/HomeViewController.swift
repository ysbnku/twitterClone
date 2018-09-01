//
//  HomeViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 28/08/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet var mentionName: UITextField!
    @IBOutlet var fullName: UITextField!
    @IBOutlet var about: UITextField!
    var ref : DatabaseReference! = Database.database().reference() //Firebase Database Bağlantısı
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveFirebase() {
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
        ref.child("mentionName").child(self.mentionName.text!).observeSingleEvent(of: .value) { (Datasnapshott) in
            if(!Datasnapshott.exists()){
                self.ref.child("users").child(userID!).child("MentionName").setValue(self.mentionName.text!)
                self.ref.child("users").child(userID!).child("FullName").setValue(self.fullName.text!)
                self.ref.child("users").child(userID!).child("about").setValue(self.about.text!)
                self.ref.child("mentionName").child(self.mentionName.text!.lowercased()).setValue(userID!)
                
            }else
            {
                print("MentionName Kontrol ET")
            }
        }
        
    }

    @IBAction func startTwitter(_ sender: Any) {
       saveFirebase()
    }
    
  
}
