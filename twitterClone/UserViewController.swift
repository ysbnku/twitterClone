//
//  UserViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 06/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet var userListTableView: UITableView!
    
    let ref:DatabaseReference! = Database.database().reference()
    let currentID = Auth.auth().currentUser?.uid
    
    var userList = [NSDictionary?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("users").queryOrdered(byChild: "email").observe(.childAdded, with: { (snapshot) in
            
            let key = snapshot.key
            let snapshot = snapshot.value as? NSDictionary
            snapshot?.setValue(key, forKey: "uid")
            if (key == self.currentID!){
                print("Bunu eklemiyorum")
                
            }else {
                self.userList.append(snapshot)
                self.userListTableView.insertRows(at: [IndexPath(row: self.userList.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
            
            }
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "users") as! UserTableViewCell
        let user:NSDictionary? = userList[indexPath.row]
        
        cell.fullName.text = user?["FullName"] as? String
        cell.mentionName.text = user?["MentionName"] as? String
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(userList[(indexPath.row)]!)
        let info = userList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let followProfilVC = storyboard.instantiateViewController(withIdentifier: "followProfilVC") as! FollowProfilViewController
        
        followProfilVC.about = String(describing: info!["about"] ?? "Hakkımda Bulunamadı")
        followProfilVC.followfullName = String(describing: info!["FullName"] ?? "Ad Bulunamadı")
        followProfilVC.MentionName = String(describing: ("@\(info!["MentionName"] ?? "Kullanıcı Adı Bulunamadı")"))
        followProfilVC.imageURL = String(describing: info!["profilPicture"] ?? "URL hatası")
        followProfilVC.didselectUid = String(describing: info!["uid"] ?? "Uid Gönderilemedi")
        
        self.present(followProfilVC, animated: true, completion: nil)

        
    }
    
    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
