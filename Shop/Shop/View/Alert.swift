//
//  Alert.swift
//  Shop
//
//  Created by Ali on 22/06/2022.
//

import Foundation
import UIKit

func showAlert(title: String, message: String, view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction  = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
    }
    alert.addAction(okAction)
    view.present(alert, animated: true, completion: nil)
}

