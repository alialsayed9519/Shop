//
//  CustomerViewModel.swift
//  Shop
//
//  Created by Ali on 19/06/2022.
//

import Foundation

class CustomerViewModel {
    let networkService: NetworkService!
    var bindErrorToView: (() -> ()) = {}
    var bindUser: (() -> ()) = {}
    
    var customer: User? {
        didSet {
            self.bindUser()
        }
    }
    
    var showError: String? {
        didSet {
            self.bindErrorToView()
        }
    }
    
    init() {
       self.networkService = NetworkService()
   }
    
    func getCustomerwith(id: String) {
        networkService.getCustomerById(id: id) { user, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
                print("\(message)        vm")
            }
            guard let user = user else {
                return
            }
            self.customer = user
            print("\(user.customer.note)        vm")
        }
    }
    
    func modifyCustomerNote(id: String, user: User) {
        networkService.updateCustomerNote(id: id, user: user) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
                print("\(message)        vm")
            }
            if let response = response as? HTTPURLResponse {
                print("\(response.statusCode)   vm")
            }
        }
    }
    
    
    
}
