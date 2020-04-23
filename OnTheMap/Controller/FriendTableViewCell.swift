//
//  FriendTableViewCell.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-21.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var studentNameLabel: UILabel!
    var mediaURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func studentURLButton(_ sender: Any) {
        let app = UIApplication.shared
        guard let mediaURL = mediaURL else {
            print("no given URL")
            return
            
        }
        
        if let urlMedia = URL(string: mediaURL) {
            app.open(urlMedia)
        } else {
            print("not valid url")
        }
    }
    
}
