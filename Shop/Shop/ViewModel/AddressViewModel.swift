//
//  AddressViewModel.swift
//  Shop
//
//  Created by yasmeen hosny on 6/8/22.
//

import Foundation


class AddressViewModel {

    var bindAddresses = {}
    var bindError = {}
    
    private var network = NetworkService()
    
    var addresses: [Address]?{
        didSet{
            self.bindAddresses()
        }
    }
    
    var error: String?{
        didSet{
            self.bindError()
        }
    }
    
    func fetchAddresses() {
        network.fetchAddresses() { (addresses, error) in
            if let message = error?.localizedDescription{
                self.error = message
                print(error?.localizedDescription ?? "NO error")
            }
            else {
                if let respons = addresses {
                  //  print(respons[0])
                    self.addresses = respons
                }
            }
        }
    }
    
    func addAddress(country: String, city: String, address: String, phone: String){
        if country != ""{
            if city != ""{
                if address != ""{
                    if phone != "" {
                        if self.isValidPhone(phone: phone){
                            let address = Address(address1: address, city: city, province: "", phone: phone, zip: "", last_name: "", first_name: "", country: country)
                            addAddress(address: address)
                        } else {
                            error = "Please enter valid phone"
                        }
                        
                    } else {
                        error = "Please enter your phone"
                    }
                    }else{
                    error = "Please enter your address"
                }
            }else{
                error = "Please enter your city"
            }
        }else{
            error = "Please enter you country"
        }
    }
    
    func addAddress(address: Address){
        let id = userDefault().getId()
        var newAddress = address
        network.addAddress(id: id, address: address) { [weak self] (data, response, error) in
            if error != nil {
                print("error while adding address \(error!)")
                self?.error = "An error occured while adding your address"
                return
            }
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                print("json: \(json)")
                let returnedCustomer = json["customer"] as? Dictionary<String,Any>
                do{
                    let reutrnedCust = try JSONDecoder().decode(Customer.self, from: data)
                    newAddress.id = reutrnedCust.customer.addresses?.last?.id ?? 0
                }catch{
                    print("could parse response: \(error.localizedDescription)")
                }
                let id = returnedCustomer?["id"] as? Int ?? 0
                if id == 0 {
                    // failed to save address
                    self?.error = "An error occured while adding your address"
                }else {
                    //succeeded to save address
                    self?.bindAddresses()
                   }
            }
        }
    }
    
    func editAddress(address: Address){
        let id = address.id!
        network.editAddress(addressId: id) { [weak self] (data, response, error) in
            if error != nil {
                print("error while editing address \(error!)")
                self?.error = "An error occured while editing your address"
                //failed to save address
                return
            }
            if let data = data{
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                print("json: \(json)")
                let returnedCustomer = json["customer_address"] as? Dictionary<String,Any>
                let id = returnedCustomer?["id"] as? Int ?? 0
                if id == 0 {
                    // failed to edit address
                    self?.error = "An error occured while editing your address"
                }else {
                    //succeeded to edit address
                    self?.bindAddresses()
                }
            }
        }
    }
    func deleteAddress(addressId: Int){
        network.deleteAddress(addrssId: addressId) { [weak self] (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any>
            if json.isEmpty {
                print("deleted")
                self?.fetchAddresses()
            }else{
                print("cant delete")
                self?.error = "We can not delete this address"
            }
        }
    }
    
    private func isValidPhone(phone: String) -> Bool {
      let phoneRegex = "^[0-9]{6,14}$";
      let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
      return valid
   }
}
