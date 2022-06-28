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
    var buttonIncrease : ()->() = {}
    var buttonDecrease : ()->() = {}
    var defaults:userDefaultsprotocol=userDefault()
    var productImage = ""
    
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
        draftOrderViewModel.getProductImageFromAPI(id: id)
        draftOrderViewModel.bindImageURLToView = { self.onSuccessUpdateView() }
        var p=item.price
        setPrice(price: &p)
    }
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
           price=price+" "+"USD"
        }
        else if currency=="EGP"{
            let m="\((Double(price)!)*18)"
           price="\(m)"+" "+"EGP"
        }
        itemPrice.text=price
    }
    
    func onSuccessUpdateView() {
        productImage = draftOrderViewModel.imageURL!
        print("\(productImage)         kkkkkkkkk")
        itemimage.sd_setImage(with: URL(string: productImage), placeholderImage: UIImage(named: "adidas.png"))
    }
    
    
}


/*
 class CartItem: UITableViewCell {
     private let draftOrderViewModel = DraftOrderViewModel()
     @IBOutlet weak var itemimage: UIImageView!
     @IBOutlet weak var itemName: UILabel!
     @IBOutlet weak var itemVonder: UILabel!
     @IBOutlet weak var itemPrice: UILabel!
     @IBOutlet weak var itemCounter: UILabel!
     
     var buttonIncrease : ((UITableViewCell) -> Void)?
     var buttonDecrease : ((UITableViewCell) -> Void)?
    
     var productImage = ""
     
     @IBAction func icreseCount(_ sender: Any) {
         buttonIncrease?(self)
     }
     
     @IBAction func decreseCount(_ sender: Any) {
         buttonDecrease?(self)
     }
     
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
    
     func updateUI(item: LineItem) {
         itemName.text = item.title
         itemVonder.text = item.vendor
         let id = String(describing: item.product_id)
         draftOrderViewModel.getProductImageFromAPI(id: id)
         draftOrderViewModel.bindImageURLToView = { self.onSuccessUpdateView() }
         itemPrice.text = String(describing: item.price)
     }
     
     func onSuccessUpdateView() {
         productImage = draftOrderViewModel.imageURL!
         itemimage.sd_setImage(with: URL(string: productImage), placeholderImage: UIImage(named: "adidas.png"))
     }
 }
 */
