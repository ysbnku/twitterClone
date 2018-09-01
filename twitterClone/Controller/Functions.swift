//
//  Functions.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 31/08/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Functions {
    func showAlert(tittleText:String, messageText:String) {
        
        let alertt = UIAlertController(title: tittleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alertt.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
      //  present(alertt,animated: true, completion: nil)
    }
    //Uyarı Fonksiyonu Bitiş
}
