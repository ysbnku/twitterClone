//
//  SignUpViewController.swift
//  
//
//  Created by Yavuz BİTMEZ on 21/08/2018.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBOutlet var passFieldAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func signUP(_ sender: AnyObject) {
    
        
        if (passField.text != passFieldAgain.text){
            print("Şifreler Uyuşmuyor")
        }
        
        else if(!(emailField.text?.isEmpty)! && !(passField.text?.isEmpty)! && !(passFieldAgain.text?.isEmpty)!){
            Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
                if(error != nil){
                    print(error!.localizedDescription)
                }
                else{
                    print("**************Kaydınız Yapıldı")
                    self.emailField.text = ""
                    self.passField.text = ""
                    self.passFieldAgain.text = ""
                }
            })
            }
        
        
        }
    


}
    
    

   



