//
//  AddressCell.swift
//  Shop
//
//  Created by yasmeen hosny on 6/7/22.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var cityAddress: UILabel!
    @IBOutlet weak var phone: UILabel!
    var editButton : (() -> Void)?
    var deleteButton : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAddress(_ sender: Any) {
        editButton?()
    }
    
    @IBAction func deleteAddress(_ sender: Any) {
        deleteButton?()
    }
    
    func updateUI(address: Address){
        country.text = address.country
        cityAddress.text = address.city! + ", " + address.address1!
        phone.text = address.phone!
    }
}
