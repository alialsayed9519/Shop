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
    
    var editAddress: Address!
    var editFlag: Bool = false
    var addressViewModel = AddressViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        addressViewModel.bindAddresses = self.bindAddresses
        addressViewModel.bindError = self.bindError
    }
    
    @IBAction func addAddress(_ sender: Any){
     //   self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.async { [self] in
            if editFlag{
                editAddress.country = TFCountry.text ?? ""
                editAddress.city = TFCity.text ?? ""
                editAddress.address1 = TFAddress.text ?? ""
                editAddress.phone = TFPhone.text ?? ""
                addressViewModel.editAddress(address: editAddress)

            }else{
                addressViewModel.addAddress(country: TFCountry.text ?? "", city: TFCity.text ?? "", address: TFAddress.text ?? "", phone: TFPhone.text ?? "")
            }

        }
        self.navigationController?.popViewController(animated: true)

        
     
    }
    
    func updateUI() {
        addAddress.layer.cornerRadius = addAddress.layer.frame.height / 2
        if editFlag {
            addAddress.setTitle("Edit Address", for: .normal)
            TFCountry.text = editAddress.country
            TFCity.text = editAddress.city
            TFAddress.text = editAddress.address1
            TFPhone.text = editAddress.phone
        }
    }
    
    func bindAddresses() {
       // self.navigationController?.popViewController(animated: true)
    }
    
    func bindError() {
        let message = addressViewModel.error
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
