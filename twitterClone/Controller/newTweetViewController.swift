//
//  newTweetViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 01/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class newTweetViewController: UIViewController,UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var textView: UITextView!
    
    var ref:DatabaseReference! = Database.database().reference()//Database bağlantı
    var users = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "Neler Oluyor"
        textView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //  func textViewDidBeginEditing(_ textView: UITextView) {}
    func textViewDidChange(_ textView: UITextView) {
        if(textView.textColor == UIColor.lightGray){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    @IBAction func sendTweet(_ sender: Any) {
        if(textView.text.count>0){
            let uniqueID = ref.child("tweets").childByAutoId().key
            let date = String(Int(NSDate().timeIntervalSince1970))
            print("date:\(date)")
            self.ref.child("tweets").child(users!.uid).child(uniqueID).child("tweet").setValue(textView.text)
            self.ref.child("tweets").child(users!.uid).child(uniqueID).child("tarih").setValue(date)
            dismiss(animated: true, completion: nil)
            
            
        }else {
            print("Tweet atmanız için tweet yazmanız lazım")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
