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
    @IBOutlet weak var addAddress: UIButton!
    
    var editAddress: Address?
    var order: Order?
    var editFlag: Bool = false
    var chooseAddressFlag = false
    var addressViewModel = AddressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addressViewModel.bindAddresses = self.navigate
        addressViewModel.bindError = self.bindError
    }
    
    @IBAction func addAddress(_ sender: Any){
        if editFlag {
            editAddress!.country = TFCountry.text ?? ""
            editAddress!.city = TFCity.text ?? ""
            editAddress!.address1 = TFAddress.text ?? ""
            editAddress!.phone = TFPhone.text ?? ""
            addressViewModel.editAddress(address: editAddress!)
        }
        else {
            addressViewModel.addAddress(country: TFCountry.text ?? "", city: TFCity.text ?? "", address: TFAddress.text ?? "", phone: TFPhone.text ?? "")
        }

    }
    
    func updateUI() {
        addAddress.layer.cornerRadius = addAddress.layer.frame.height / 2
        if editFlag {
            addAddress.setTitle("Edit Address", for: .normal)
            TFCountry.text = editAddress!.country
            TFCity.text = editAddress!.city
            TFAddress.text = editAddress!.address1
            TFPhone.text = editAddress!.phone
        }
    }
    
    func bindAddresses() {
//        let newAddress = Address(address1: TFAddress.text, city: TFCity.text, province: "", phone: TFPhone.text, zip: "", last_name: "", first_name: "", country: TFCountry.text, id: nil)
  //      let addressText = "\(String(describing: newAddress.country)), \(String(describing: newAddress.city)), \(String(describing: newAddress.address1))"
        var message: String
     //   var view: UIViewController
        if chooseAddressFlag{
            message = "Your order will be shipped to this address: \n"
            let payment = PaymentVc()
         //   self.order?.pilling_address = newAddress
            payment.order = self.order
          //  view = payment
        } else {
            if editFlag{
                message = "You just edited the old address to be:\n"
            } else{
                message = "You just added this address:\n"
            }
          //  view = ProfileVc()
        }
        let alert = UIAlertController(title: "Addresses", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)

          //  self.navigationController?.pushViewController(view, animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bindError() {
        let message = addressViewModel.error
        showAlert(title: "Error", message: message!, view: self)
    }
    
    func navigate() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
      //  self.navigationController?.pushViewController(AddressesTable(), animated: true)
    }
}
