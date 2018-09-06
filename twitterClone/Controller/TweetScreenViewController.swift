//
//  TweetScreenViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 01/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class TweetScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let ref:DatabaseReference! = Database.database().reference()
    let usID = Auth.auth().currentUser
    

    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets = [String]()
    var dates = [String]()
    var userInfo = [String]()
    var imageURL = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        ref.child("users").child(usID!.uid).observeSingleEvent(of: .value) { (snapshot) in
            let userValue = snapshot.value as? NSDictionary
            let name = userValue?["FullName"]
            let mentionName = userValue?["MentionName"]
            let profilURL = userValue?["profilPicture"] as? String ?? ""

            self.userInfo.append(name as! String)
            self.userInfo.append(mentionName as! String)
            self.userInfo.append(profilURL as? String ?? "")
            
            
            
        
        
            self.ref.child("tweets/\(self.usID!.uid)").observe(.childAdded, with: { (snapshot) in
          
        
            let value = snapshot.value as? NSDictionary
                let tweet = value?["tweet"] as! String
               //let date = value?["tarih"] as! String
                
                self.tweets.append(tweet as! String)
                //self.dates.append(date as! String)
            self.tweetsTableView.insertRows(at: [IndexPath(row: self.tweets.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        })
        
        }
        }
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! SingleTweetTableViewCell
        cell.tweet.isEditable = false
        let imageView = cell.profilPicture!
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
     //  print(userInfo[2])
        cell.tweet.text = tweets[indexPath.row]
       // cell.config(profilPicture: "", name: userInfo[0], mentionName: userInfo[1])
        cell.config(profilPicture: userInfo[2], name: userInfo[0], mentionName: userInfo[1])
        

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
