//
//  SignInViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 25/08/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    


    @IBOutlet var kullanıcıID: UITextField!
    @IBOutlet var kullanıcıPass: UITextField!
    var ref:DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        if (!(kullanıcıID.text?.isEmpty)! && !(kullanıcıPass.text?.isEmpty)!) {
            if (isValidEmail(testStr: kullanıcıID.text!) == false){         //KULLANICI ADI İLE GİRİŞ YAPMA
                ref.child("mentionName").child(kullanıcıID.text!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if DataSnapshot.exists(){
                        let uid = DataSnapshot.value as! String
                        self.ref.child("users").child(uid).child("email").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                            if DataSnapshot.exists() {
                                let email = DataSnapshot.value as! String
                               self.logInWithEmail(email: email, password: self.kullanıcıPass.text!)
                            }else{
                               self.showAlert(tittleText: "", messageText: "Birşeyler yanlış gidiyor.")
                            }
                        })
                    }else{
                        self.showAlert(tittleText: "", messageText: "Birşleyler Yanlış Gitti")
                    }
                    
                })
            }
            else{
            logInWithEmail(email: kullanıcıID.text!, password: kullanıcıPass.text!)

            }
            

        } else {showAlert(tittleText: "Lütfen", messageText: "Boş Alanları Doldurunuz")}

    }

    // Keyboard Done Fonksiyonu
    func textFieldShouldReturn(_ textField: UITextField) ->Bool {
        textField.resignFirstResponder()
        return true
    }
    //Keyboard Done Fonksiyonu Bitiş
    
    
    //Hatalı Bilgi Uyarı Fonksiyonu
    
    func showAlert(tittleText:String, messageText:String) {
        
    let alertt = UIAlertController(title: tittleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
    alertt.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
    self.present(alertt,animated: true, completion: nil)
    }
    //Uyarı Fonksiyonu Bitiş
    
    //Giriş Fonksiyonu
    func logInWithEmail(email:String , password:String){
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if(error != nil )
                {
                    if let hataKodu = AuthErrorCode(rawValue: error!._code) {
                        switch hataKodu {
                        case .wrongPassword:
                            self.showAlert(tittleText: "Yanlış şifre", messageText: "Hatalı Parola Girdiniz")
                        case .invalidEmail:
                            self.showAlert(tittleText: "Yanlış Email", messageText: "Hatalı Email Girdiniz")
                        case .networkError:
                            self.showAlert(tittleText: "Bağlantı Hatası", messageText: "Bağlantınızda bir hata meydana geldi")
                        default:
                            self.showAlert(tittleText: "Bilinmeyen Hata", messageText: "Fatal Error")
                        }
                    }
                    
                }else
                {
                    let uid = Auth.auth().currentUser?.uid
                    self.ref.child("users").child(uid!).observeSingleEvent(of: .value , with: { (DataSnapshot) in
                        let value = DataSnapshot.value as? NSDictionary
                        let mentionName = value?["MentionName"] as? String ?? ""
                        print(mentionName)
                        
                        if !(mentionName.isEmpty) {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let startTweet = storyboard.instantiateViewController(withIdentifier: "tweetScreen") as! TweetScreenViewController
                            self.present(startTweet, animated: true, completion: nil)
                            
                        }else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                            self.present(homeVC, animated: true, completion: nil)
                        }
                    })
                    
                    
                }
            }
        }

    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    }

