//
//  CartItem.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit

class CartItem: UITableViewCell {

    @IBOutlet weak var itemimage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemCounter: UILabel!
    
    var count: Int!
    
    @IBAction func icreseCount(_ sender: Any) {
        count = Int(self.itemCounter.text!)
        itemCounter.text = "\(count += 1)"
    }
    
    @IBAction func decreseCount(_ sender: Any) {
        count = Int(self.itemCounter.text!)
        itemCounter.text = "\(count -= 1)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(item: Product) {
        itemName.text = item.itemName
        itemSize.text = item.itemSize
        itemCounter.text = "\(item.itemCount)"
        itemPrice.text = "\(item.itemprice)"
    }
    
}
