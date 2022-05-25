//
//  UITableView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import Foundation

import UIKit

extension UITableView{
    
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type){
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    
    func dequeueNib<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Cell not found")
        }
        return cell
    }
}

