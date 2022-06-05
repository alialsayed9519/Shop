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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(product: Product) {
        self.productPrice.text = product.title
        //self.productImage.sd_setImage(with: URL(string: product.images[0].src ?? "adidas"), placeholderImage: UIImage(named: "adidas"))
    }
    
}
