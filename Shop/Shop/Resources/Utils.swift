//
//  Utils.swift
//  Shop
//
//  Created by yasmeen hosny on 6/19/22.
//

import Foundation
import UIKit

class utils{
    
    static func showAlert(message: String, title: String, view: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
}
