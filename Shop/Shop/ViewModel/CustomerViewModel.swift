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
    var bindReload: (() -> ()) = {}
    
    var reload: Bool? {
        didSet {
            self.bindReload()
        }
    }
    
    
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
                print("\(message)    getCustomerwith  error    vm")
            }
            guard let user = user else {
                return
            }
            self.customer = user
            print("\(user.customer.id)    user.customer.id  sucss    vm")
            print("\(user.customer.note)    user.customer.note  sucss    vm")
            print("\(user.customer.last_name)    user.customer.last_name  sucss    vm")
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
                print("\(response.statusCode)   modifyCustomerNote  CustomerViewModel   vm")
            }
            self.reload = true
        }
    }
    
        func modifyCustomerFav(id: String, user: User) {
            networkService.updateCustomerFav(id: id, user: user) { data, response, error in
                if let error: Error = error {
                    let message = error.localizedDescription
                    self.showError = message
                    print("\(message)        vm")
                }
                if let response = response as? HTTPURLResponse {
                    print("\(response.statusCode)   modifyCustomerNote  CustomerViewModel   vm")
                }
            }
        }
    
    
    
}
