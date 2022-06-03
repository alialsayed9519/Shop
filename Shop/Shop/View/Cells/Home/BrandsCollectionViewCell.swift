//
//  BrandsCollectionViewCell.swift
//  Shop
//
//  Created by Ali on 28/05/2022.
//

import UIKit
import SDWebImage

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(brand: SmartCollection) {
        self.name.text = brand.title
        //self.image.image = UIImage(named: (brand.image.src))
        
        image.sd_setImage(with: URL(string: brand.image.src), placeholderImage: UIImage(named: "adidas.png"))
        
        self.image.roundedImage()
    }

}
