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
    
    @IBOutlet weak var favProductBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(product: Product) {
        self.productPrice.text = product.variants?[0].price ?? "123"
        self.productImage.sd_setImage(with: URL(string: product.images![0].src ?? "adidas"), placeholderImage: UIImage(named: "adidas"))

    }
    
}
