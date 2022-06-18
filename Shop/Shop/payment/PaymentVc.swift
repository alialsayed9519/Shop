//
//  PaymentVc.swift
//  Shop
//
//  Created by Salma on 09/06/2022.
//

import UIKit

class PaymentVc: UIViewController {

    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var onlineButton: UIButton!
    
    var orderAddress: Address?
    var orderItems: [LineItems]?
    var customer: Customer?
    var discountCode: Price_Rule?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.discountView.layer.cornerRadius = 20
        self.paymentView.layer.cornerRadius = 20
        
    }

   
    @IBAction func cashPayment(_ sender: Any) {
    }
    
    @IBAction func onlinePayment(_ sender: Any) {
    }
}
