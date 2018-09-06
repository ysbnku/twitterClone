//
//  SingleTweetTableViewCell.swift
//  twitterClone
//
//  Created by Yavuz BİTMEZ on 03/09/2018.
//  Copyright © 2018 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class SingleTweetTableViewCell: UITableViewCell {

    
    @IBOutlet var profilPicture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var tweet: UITextView!
    @IBOutlet var mentionName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func config(profilPicture:String? , name: String ,mentionName:String){
        self.mentionName.text = "@"+mentionName
        self.name.text = name
        
        if(profilPicture != ""){
          //let imageData = NSData(contentsOf: NSURL(string:profilPicture!)! as URL)
            if let url = URL(string:profilPicture!) {
                do{
                    let imageData = try Data(contentsOf: url)
                    self.profilPicture.image = UIImage(data: imageData as! Data)
                    


                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }else {
            self.profilPicture.image = UIImage(named: "egg")
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
