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

    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var TFcopun: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var LPrice: UILabel!
    @IBOutlet weak var LDiscount: UILabel!
    @IBOutlet weak var LShipping: UILabel!
    @IBOutlet weak var LTotale: UILabel!
   
  var order: Order?
    var price: Int?
    var total: Int?
    var currency: String?
    
    private let viewModel = OrderViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        self.discountView.layer.cornerRadius = 20
        self.paymentView.layer.cornerRadius = 20
        self.detailsView.layer.cornerRadius = 20
        self.continueButton.layer.cornerRadius = 20
        self.applyButton.layer.cornerRadius = 20
        
        price = Int((order?.current_total_price) ?? "0") ?? 0
        total = price! + 15
        currency = userDefault().getCurrency()
        
        self.LPrice.text = "\(String(describing: price)).00 \(String(describing: currency))"
        self.LDiscount.text = "0.00 \(String(describing: currency))"
        self.LShipping.text = "15.00 \(String(describing: currency))"
        self.LTotale.text = "\(String(describing: total)).00 \(String(describing: currency))"
    }



    func payMent(){
        print("salmaaaaaa")
        func fetchClientToken() {
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
    @IBAction func cashPayment(_ sender: Any) {
        order?.gateway = "Cash On Delivery"
    }
    
    @IBAction func onlinePayment(_ sender: Any) {
        order?.gateway = "Paypal"
    }
    @IBAction func continuePayment(_ sender: Any) {
        order?.currency = self.currency
        order?.email = userDefault().getEmail()
        switch order?.gateway {
        case "Cash On Delivery":
            viewModel.postOrder(order: order!)
        //    self.navigationController?.pushViewController(, animated: <#T##Bool#>)
        default:
            print("Ay 7aga")
        }
    }
    
    @IBAction func applydiscountCode(_ sender: Any) {
        let discount = viewModel.checkDescountCode(copun: TFcopun.text ?? "")
        utils.showAlert(message: discount.1, title: "Discount Code", view: self)
        total = 15 + price! - (price! * (discount.0 / 100))
        
        //MARK: - Update Order
        order?.discount = "\(discount.0)"
        order?.current_total_price = "total"
        
        //MARK: - Update labels
        self.LDiscount.text = "\(discount.0).00 \(String(describing: currency))"
        self.LTotale.text = "\(String(describing: total)).00 \(String(describing: currency))"
    }    
}
