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
    
    private let favoriteViewModel = FavoriteViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(product: Product) {
        self.productPrice.text = product.variants?[0].price ?? "123"
        self.productImage.sd_setImage(with: URL(string: product.images[0].src ?? "adidas"), placeholderImage: UIImage(named: "adidas"))
        self.favProductBtn.setTitle("", for: .normal)
     
        if favoriteViewModel.isProductFavoriteWith(id: product.variants![0].id) {
            print("\(product.variants![0].id)     ididididididididi")
            let image = UIImage(named: "")
            self.favProductBtn.setImage(image, for: .normal)
        }
        
        
    }
    
}


