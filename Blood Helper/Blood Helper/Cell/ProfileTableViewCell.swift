//
//  ProfileTableViewCell.swift
//  Blood Helper
//
//  Created by MacOS on 10/04/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileBloodImage: UIImageView!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileView.layer.cornerRadius = 8
        
    }
    
   

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
