//
//  FollowProfilViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 07/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase


class FollowProfilViewController: UIViewController {

    @IBOutlet var FollowfullName: UILabel!
    @IBOutlet var FollowMentionName: UILabel!
    @IBOutlet var aboutInfo: UILabel!
    @IBOutlet var imageBox: UIImageView!
    @IBOutlet var followbtn: UIButton!
    
    var followfullName:String!
    var MentionName:String!
    var about:String!
    var imageURL:String!
    var didselectUid:String?
    var followButton:Bool = false
    
    let currentID = Auth.auth().currentUser
    let ref:DatabaseReference = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FollowMentionName.text = MentionName
        FollowfullName.text = followfullName
        aboutInfo.text = about

        if let url = URL(string: imageURL){
            do{
                let imageData = try Data(contentsOf: url)
                self.imageBox.image = UIImage(data: imageData as! Data)
            }catch let error {
                print(error.localizedDescription)
            }
        }else {
            self.imageBox.image = UIImage(named: "egg")
        }
       
        
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func follow(_ sender: Any) {
        if !followButton{
            let uniqueID = ref.child("followers").childByAutoId().key
            let save = ["followers/\(self.currentID!.uid)/\(uniqueID)/MentionName":MentionName,"followers/\(self.currentID!.uid)/\(uniqueID)/FullName":followfullName] as [String : Any]
            self.ref.updateChildValues(save)
            
            self.followbtn.setTitle("Takibi Bırak", for: .normal)
            followButton = true
        }else {
            ref.child("followers/\(self.currentID!.uid)").queryOrdered(byChild: "MentionName").queryEqual(toValue: MentionName).observe(.childAdded, with: { (snapshot) in
             snapshot.ref.removeValue()
                self.ref.child("followers").removeAllObservers()
            })
            self.followbtn.setTitle("Takip Et", for: .normal)
            followButton = false
        }
    }
    

}
