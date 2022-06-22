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

 //   var product : Pproduct = Pproduct(quant: 1)
      private var counterValue = 1
  //    var productIndex = 0
    
    var buttonIncrease : ((UITableViewCell) -> Void)?
    var buttonDecrease : ((UITableViewCell) -> Void)?
   
    //  var cartSelectionDelegate: CartSelection?
 //   var item: LineItems?
    var productImage = ""
  //  var count: Int = 1
    
    @IBAction func icreseCount(_ sender: Any) {
        buttonIncrease?(self)

    //    count = count + 1
     //   itemCounter.text = "\(count)"
     //   draftOrderViewModel.increaseItemQuantaty(orderItem: item!)
     //   print(count)
      //  product.quant = count
     //   cartSelectionDelegate?.addProductToCart(product: product, atindex: productIndex)
    }
    
    @IBAction func decreseCount(_ sender: Any) {
        buttonDecrease?(self)

      //  if count > 1 {
       //     count = count - 1
       //     itemCounter.text = "\(count)"
      //  }
      //  product.quant = count
    //   cartSelectionDelegate?.addProductToCart(product: product, atindex: productIndex)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    func updateUI(item: LineItem) {
      //  self.item = item
        itemName.text = item.title
     //   itemCounter.text = String(describing: item.quantity)
      //  itemCounter.text = String(describing: count)
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
/*
struct Pproduct {
    var quant: Int
}
*/
