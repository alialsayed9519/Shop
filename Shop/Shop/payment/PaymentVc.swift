//
//  PaymentVc.swift
//  Shop
//
//  Created by Salma on 09/06/2022.
//

import UIKit
import Braintree
class PaymentVc: UIViewController {
    var braintreeClient: BTAPIClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }



    func payMent(){
        braintreeClient = BTAPIClient(authorization: "sandbox_v26b7763_zchjhvj48cst95wd")!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)

                // Specify the transaction amount here. "2.32" is used in this example.
                let request = BTPayPalCheckoutRequest(amount: "2.32")
                request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options

                payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
                    if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                        print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                        // Access additional information
                        let email = tokenizedPayPalAccount.email
                        let firstName = tokenizedPayPalAccount.firstName
                        let lastName = tokenizedPayPalAccount.lastName
                        let phone = tokenizedPayPalAccount.phone

                        // See BTPostalAddress.h for details
                        let billingAddress = tokenizedPayPalAccount.billingAddress
                        let shippingAddress = tokenizedPayPalAccount.shippingAddress
                    } else if let error = error {
                        // Handle error here...
                    } else {
                        // Buyer canceled payment approval
                    }
                }
    }
    @IBAction func pay(_ sender: Any) {
        payMent()
    }
}

