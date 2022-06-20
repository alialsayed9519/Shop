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
 
 
