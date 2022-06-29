//
//  ProfileTableViewCell.swift
//  Shop
//
//  Created by Ali on 28/05/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var currLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var name: UILabel!
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
