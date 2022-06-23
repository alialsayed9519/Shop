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
    private let favoriteViewModel = FavoriteViewModel()
    var defaults:userDefaultsprotocol=userDefault()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
            print(price)
            let m="\((Double(price)!)*18)"
            print (m)
           price="\(m)"+" "+"USD"
            //price="\(price)"+""+"USD"
        }
        else if currency=="EGP"{
            price=price+" "+"EGP"
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
     
        if favoriteViewModel.isProductFavoriteWith(id: product.variants![0].id) {
            print("\(product.variants![0].id)     ididididididididi")
            let image = UIImage(named: "")
            self.favProductBtn.setImage(image, for: .normal)
        }
        
        
    }
    
}


