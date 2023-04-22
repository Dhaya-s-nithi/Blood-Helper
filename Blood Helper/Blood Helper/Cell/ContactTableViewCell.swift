//
//  ContactTableViewCell.swift
//  Blood Helper
//
//  Created by MacOS on 19/04/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var bloodImage: UIImageView!
    
    @IBOutlet weak var ContactName: UILabel!
    
    @IBOutlet weak var ContactPhone: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
