//
//  CatagoryCollectionViewCell.swift
//  Shop
//
//  Created by Ali on 28/05/2022.
//

import UIKit

class CatagoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(brand: Brand) {
        self.productPrice.text = brand.name
        self.productImage.image = UIImage(named: brand.image)
    }
    
}
