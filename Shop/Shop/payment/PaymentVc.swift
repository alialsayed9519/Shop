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
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var TFcopun: UITextField!
    
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.discountView.layer.cornerRadius = 20
        self.paymentView.layer.cornerRadius = 20
        self.continueButton.layer.cornerRadius = 20
        
    }
    @IBAction func cashPayment(_ sender: Any) {
        order?.gateway = "Cash On Delivery"
    }
    
    @IBAction func onlinePayment(_ sender: Any) {
        order?.gateway = "Paypal"
    }
    @IBAction func continuePayment(_ sender: Any) {
    }
}
 
 
