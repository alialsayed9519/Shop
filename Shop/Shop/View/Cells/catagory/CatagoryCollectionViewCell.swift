//
//  CatagoryCollectionViewCell.swift
//  Shop
//
//  Created by Ali on 28/05/2022.
//

import UIKit
import SDWebImage

class CatagoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet  var favProductBtn: UIButton!
    
    @IBOutlet weak var producTitle: UILabel!
    //private let favoriteViewModel = FavoriteViewModel()
    private let draftOrderViewModel = DraftOrderViewModel()
    var prodImage = ""
    
    var defaults:userDefaultsprotocol=userDefault()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
            print(price)
            price="\(price)"+" "+"USD"
        }
        else if currency=="EGP"{
            let m="\((Double(price)!)*18)"
           price="\(m)"+" "+"EGP"
        }
        self.productPrice.text=price
    }
    func updateUI(product: Product) {
        var p=product.variants![0].price

        //self.productPrice.text = product.variants?[0].price ?? "`123`"
       setPrice(price: &p)
        
        let fullTitle = product.title.components(separatedBy: " | ")

        var fistpart: String = fullTitle[0]
        var secondpArt: String = fullTitle[1]
        self.producTitle.text=secondpArt
        self.productImage.sd_setImage(with: URL(string: product.images[0].src), placeholderImage: UIImage(named: "adidas"))
        self.favProductBtn.setTitle("", for: .normal)
    }
    
    func updateFavoriteUI(item: LineItem) {
       
        
  
        if #available(iOS 13.0, *) {
            let i = UIImage(systemName: "heart.fill")
            favProductBtn.setTitle("", for: .normal)
            favProductBtn.setImage(i, for: .normal)
           // favProductBtn.tintColor = .red
            
        } else {
            // Fallback on earlier versions
        }
        
        
        self.productPrice.text = item.price
        self.producTitle.text = item.title
        let id = String(describing: item.product_id)
        draftOrderViewModel.getProductImageFromAPI(id: id)
        draftOrderViewModel.bindImageURLToView = { self.onSuccessUpdateView() }
    }
    
    func onSuccessUpdateView() {
        prodImage = draftOrderViewModel.imageURL!
        print(prodImage)
        productImage.sd_setImage(with: URL(string: prodImage), placeholderImage: UIImage(named: "adidas.png"))
    }
    
}
