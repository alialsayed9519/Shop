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
                print(error?.localizedDescription)
            }
            else {
                if let respons = addresses {
                    print(respons[0])
                    self.addresses = respons
                }
            }
        }
    }
}
