//
//  UIImage.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 4
    }
}
