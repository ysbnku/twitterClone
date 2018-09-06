//
//  ProfilViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 04/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Firebase

class ProfilViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet var fullName: UILabel!
    @IBOutlet var mentionName: UILabel!
    @IBOutlet var about: UILabel!
    @IBOutlet var profilPicture: UIImageView!

    
    
    @IBOutlet var medyaContainer: UIView!
    @IBOutlet var begeniContainer: UIView!
    @IBOutlet var tweetContainer: UIView!
    
    var ref:DatabaseReference = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var currentUserID = Auth.auth().currentUser
    var userData:NSDictionary?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilPicture.layer.cornerRadius = 5
        profilPicture.layer.borderColor = UIColor.white.cgColor
        profilPicture.layer.masksToBounds = true
        
        self.ref.child("users").child(currentUserID!.uid).observeSingleEvent(of: .value) { (snapshot) in
            let snapshot = snapshot.value as! NSDictionary
            self.userData = snapshot
            
            self.fullName.text = snapshot["FullName"] as? String
            self.mentionName.text = "@\(snapshot["MentionName"] as? String ?? "")"
            self.about.text = snapshot["about"] as? String
            
        
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func icerikGoruntuleme(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            UIView.animate(withDuration: 0.2, animations: {
                self.tweetContainer.alpha = 1
                self.begeniContainer.alpha = 0
                self.medyaContainer.alpha = 0
                
            })
          
            
        }else if (sender.selectedSegmentIndex == 1){
            UIView.animate(withDuration: 0.2, animations: {
                self.tweetContainer.alpha = 0
                self.begeniContainer.alpha = 0
                self.medyaContainer.alpha = 1
                
            })
            
        }else {
            UIView.animate(withDuration: 0.2, animations: {
                self.tweetContainer.alpha = 0
                self.begeniContainer.alpha = 1
                self.medyaContainer.alpha = 0
                
            })
           
        }
    }
    
    @IBAction func loginOut(_ sender: Any) {
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hosgeldinVC = storyboard.instantiateViewController(withIdentifier: "mainView") as! ViewController
        self.present(hosgeldinVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func setting(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Profil Resmi", message: "Profil Resmi Seçiniz", preferredStyle: .actionSheet)
        let resimGalerisi = UIAlertAction(title: "Resimler", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        let kamera = UIAlertAction(title: "Kameradan Çek", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheet.addAction(resimGalerisi)
        actionSheet.addAction(kamera)
        actionSheet.addAction(UIAlertAction(title: "İptal", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilResmiAyarlama(self.profilPicture, imageToSet: image)
            if let imageData :Data = UIImagePNGRepresentation(self.profilPicture.image!){
                let profilPicStorageRef = storageRef.child("users/\(String(describing: currentUserID!.uid))/profilPicture")
                let _ = profilPicStorageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if (error == nil){
                        let downloadURL = metadata!.downloadURL()
                        self.ref.child("users").child(self.currentUserID!.uid).child("profilPicture").setValue(downloadURL?.absoluteString)
                    }else {
                        print(error)
                    }
                })
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
 
    func profilResmiAyarlama(_ imageView:UIImageView, imageToSet:UIImage){
    imageView.image = imageToSet
    }
    
}
