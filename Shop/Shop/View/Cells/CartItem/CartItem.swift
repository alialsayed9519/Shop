//
//  CartItem.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit
import SDWebImage

class CartItem: UITableViewCell {
    private let draftOrderViewModel = DraftOrderViewModel()
    @IBOutlet weak var itemimage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemCounter: UILabel!
    var ima = ""
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


    
    func updateUI(item: LineItems) {
        itemName.text = item.title
   //     itemCounter.text = String(describing: itemCounter)
        itemCounter.text = String(describing: item.quantity)
       
        let id = String(describing: item.product_id)
        draftOrderViewModel.getProductImageFromAPI(id: id)
        draftOrderViewModel.bindImageURLToView = { self.onSuccessUpdateView() }

        itemPrice.text = String(describing: item.price)
    }
    
    func onSuccessUpdateView() {
        ima = draftOrderViewModel.imageURL!
        itemimage.sd_setImage(with: URL(string: ima), placeholderImage: UIImage(named: "adidas.png"))
    }
    
}
