//
//  UICollectionView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/30/22.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type){
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    
    func dequeueNib<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Cell not found")
        }
        return cell
    }
}
