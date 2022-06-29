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
    var braintreeClient: BTAPIClient!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var onlineButton: UIButton!
    
    @IBOutlet weak var TFcopun: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var LTotale: UILabel!

    @IBOutlet weak var LShipping: UILabel!
    @IBOutlet weak var LDiscount: UILabel!
    @IBOutlet weak var LPrice: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    
    var order: Order?
    var price: Double = 0.0
    var total: Double = 0.0
    var currency: String = ""
    var subPrice:Double = 0.0
    private let viewModel = OrderViewModel()

        

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
          
            self.discountView.layer.cornerRadius = 20
            self.paymentView.layer.cornerRadius = 20
            self.detailsView.layer.cornerRadius = 20
            self.continueButton.layer.cornerRadius = 20
            self.applyButton.layer.cornerRadius = 20
            
            price = Double((order?.current_total_price ?? "0.0") ) ?? 0.0
            total = subPrice + 15

            currency = userDefault().getCurrency()
            
            self.LPrice.text = "\(subPrice) \(currency)"
            self.LDiscount.text = "0.00 \(String(describing: currency))"
            self.LShipping.text = "15.00 \(String(describing: currency))"
            self.LTotale.text = "\(String(describing: total)) \(String(describing: currency))"
        }
        func payMent(){
            braintreeClient = BTAPIClient(authorization: "sandbox_v26b7763_zchjhvj48cst95wd")!
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)

                    // Specify the transaction amount here. "2.32" is used in this example.
            let request = BTPayPalCheckoutRequest(amount: (LTotale?.text)!)
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
                            self.viewModel.postOrder(order: self.order!)
                            self.navigationController?.pushViewController(doneVc(), animated: true)
                        } else if let error = error {
                            // Handle error here...
                        } else {
                            // Buyer canceled payment approval
                        }
                      //  self.viewModel.postOrder(order: self.order!)
                    }
        }
       
        @IBAction func cashPayment(_ sender: Any) {
            order?.gateway = "Cash On Delivery"
            cashButton.setImage(UIImage(named: "radioOn"),for: .normal)
            onlineButton.setImage(UIImage(named: "radioOf"),for: .normal)
        }
        
        @IBAction func onlinePayment(_ sender: Any) {
            order?.gateway = "Paypal"
            onlineButton.setImage(UIImage(named: "radioOn"),for: .normal)
            cashButton.setImage(UIImage(named: "radioOf"),for: .normal)

        }

    @IBAction func continuePayment(_ sender: Any) {
        order?.currency = self.currency
        order?.email = userDefault().getEmail()
        switch order?.gateway {
        case "Cash On Delivery":
            viewModel.postOrder(order: order!)
            self.navigationController?.pushViewController(doneVc(), animated: true)
        case "Paypal":
//            payMent()
            print("salma elawadyyasmeen")
        default:
            print("Ay 7aga")
        }
    }
    
  
        
        @IBAction func applydiscountCode(_ sender: Any) {
            let discount = viewModel.checkDescountCode(copun: TFcopun.text ?? "")
            utils.showAlert(message: discount.1, title: "Discount Code", view: self)
            total = 15 + Double(price) - Double(discount.0)
            
            //MARK: - Update Order
            order?.total_discounts = "\(discount.0)"
            order?.current_total_price = "\(total)"
            
            //MARK: - Update labels
            self.LDiscount.text = "\(discount.0).00 \(String(describing: currency))"
            self.LTotale.text = "\(String(describing: total)).00 \(String(describing: currency))"
        }
    }
