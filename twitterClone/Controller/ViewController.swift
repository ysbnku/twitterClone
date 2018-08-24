//
//  ViewController.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 20/08/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var kaydolbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kaydolbutton.layer.cornerRadius = 8
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

