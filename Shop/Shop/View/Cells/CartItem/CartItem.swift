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


    
    func updateUI(item: Product) {
        itemName.text = item.title
        itemCounter.text = String(describing: itemCounter)
        itemPrice.text = String(describing: item.variants)
    }
    
}
