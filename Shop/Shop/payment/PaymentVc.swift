//
//  PaymentVc.swift
//  Shop
//
//  Created by Salma on 09/06/2022.
//

import UIKit
//import Braintree
import BraintreeDropIn
class PaymentVc: UIViewController {
 // var braintreeClient: BTAPIClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }



    func payMent(){
//        braintreeClient = BTAPIClient(authorization: "sandbox_v26b7763_zchjhvj48cst95wd")!
//        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
//
//                // Specify the transaction amount here. "2.32" is used in this example.
//                let request = BTPayPalCheckoutRequest(amount: "2.32")
//                request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options
//
//                payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
//                    if let tokenizedPayPalAccount = tokenizedPayPalAccount {
//                        print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
//
//                        // Access additional information
//                        let email = tokenizedPayPalAccount.email
//                        let firstName = tokenizedPayPalAccount.firstName
//                        let lastName = tokenizedPayPalAccount.lastName
//                        let phone = tokenizedPayPalAccount.phone
//
//                        // See BTPostalAddress.h for details
//                        let billingAddress = tokenizedPayPalAccount.billingAddress
//                        let shippingAddress = tokenizedPayPalAccount.shippingAddress
//                    } else if let error = error {
//                        // Handle error here...
//                    } else {
//                        // Buyer canceled payment approval
//                    }
//                }
        print("salmaaaaaa")
        func fetchClientToken() {
            // TODO: Switch this URL to your own authenticated API
            let clientTokenURL = NSURL(string: "sandbox_v26b7763_zchjhvj48cst95wd")!
            let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
            clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")

            URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
                // TODO: Handle errors
                let clientToken = String(data: data!, encoding: String.Encoding.utf8)

                // As an example, you may wish to present Drop-in at this point.
                // Continue to the next section to learn more...
                }.resume()
        }
        showDropIn(clientTokenOrTokenizationKey: "sandbox_v26b7763_zchjhvj48cst95wd")
    }
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                print("sucessfully paid")
                // Use the BTDropInResult properties to update your UI
                // result.paymentMethodType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    @IBAction func pay(_ sender: Any) {
        payMent()
    }
}

