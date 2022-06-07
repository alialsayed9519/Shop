//
//  AddAddress.swift
//  Shop
//
//  Created by yasmeen hosny on 6/7/22.
//

import UIKit

class AddAddress: UIViewController {
    
    @IBOutlet weak var TFCountry: UITextField!
    @IBOutlet weak var TFCity: UITextField!
    @IBOutlet weak var TFAddress: UITextField!
    @IBOutlet weak var TFPhone: UITextField!
    
    var editFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAddress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
