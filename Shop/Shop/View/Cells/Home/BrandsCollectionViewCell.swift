//
//  BrandsCollectionViewCell.swift
//  Shop
//
//  Created by Ali on 28/05/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(brand: Brand) {
        self.name.text = brand.name
        self.image.image = UIImage(named: brand.image)
        self.image.roundedImage()
    }

}
