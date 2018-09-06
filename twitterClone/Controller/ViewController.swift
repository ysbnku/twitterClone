//
//  ViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 20/08/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var kaydolbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kaydolbutton.layer.cornerRadius = 8
        
    
    }
    
    override  func viewDidAppear(_ animated: Bool) {
if let email = UserDefaults.standard.object(forKey: "email") as? String , let password = UserDefaults.standard.object(forKey: "password") as? String
        {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if (error != nil){
                    print("HATAAAA")
                }else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let twitterHomeVC = storyboard.instantiateViewController(withIdentifier: "tweetScreen")
                    self.present(twitterHomeVC, animated: true, completion: nil)
                }
            })
        }else {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

