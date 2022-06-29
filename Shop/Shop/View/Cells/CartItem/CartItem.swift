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
    @IBOutlet weak var itemVonder: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemCounter: UILabel!
    @IBOutlet weak var deleteItem: UIButton!
    
    @IBOutlet weak var icreseCount: UIButton!
    @IBOutlet weak var decreseCount: UIButton!
    
    var buttonIncrease : ()->() = {}
    var buttonDecrease : ()->() = {}
    var defaults:userDefaultsprotocol=userDefault()
    var productImage = ""
    var number: Int?
    @IBAction func icreseCount(_ sender: Any) {
        buttonIncrease()
    }
    
    @IBAction func decreseCount(_ sender: Any) {
        buttonDecrease()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    func updateUI(item: LineItem) {
        itemName.text = item.title
        itemCounter.text = String(item.quantity)
        itemVonder.text = item.vendor
        let id = String(describing: item.product_id)
        draftOrderViewModel.getProductFromAPI(id: id)
        draftOrderViewModel.bindProductToView = { self.onSuccessUpdateView() }
        
        var p=item.price
        setPrice(price: &p)
    }
    
    func updateFav(item: LineItem) {
        itemCounter.isHidden = true
        icreseCount.isHidden = true
        decreseCount.isHidden = true
        itemName.text = item.title
        itemCounter.text = String(item.quantity)
        itemVonder.text = item.vendor
        let id = String(describing: item.product_id)
        draftOrderViewModel.getProductFromAPI(id: id)
        draftOrderViewModel.bindProductToView = { self.onSuccessUpdateView() }
    }
    
    
    
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
            let m="\((Double(price)!)/18)"
           price="\(m)"+" "+"USD"
          
        }
        else if currency=="EGP"{
            price=price+" "+"EGP"
        }
        itemPrice.text=price
    }
    
    func onSuccessUpdateView() {
        var max = draftOrderViewModel.product?.variants?[0].inventory_quantity
        number = max!
        productImage = (draftOrderViewModel.product?.images[0].src)!
        itemimage.sd_setImage(with: URL(string: productImage), placeholderImage: UIImage(named: "adidas.png"))
    }
    
    
}

