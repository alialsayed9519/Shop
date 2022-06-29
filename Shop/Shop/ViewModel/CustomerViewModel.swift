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
            }
            guard let user = user else {
                return
            }
            self.customer = user
        }
    }
    
    func modifyCustomerNote(id: String, user: User) {
        networkService.updateCustomerNote(id: id, user: user) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            }
            if let response = response as? HTTPURLResponse {
            }
            self.reload = true
        }
    }
    
        func modifyCustomerFav(id: String, user: User) {
            networkService.updateCustomerFav(id: id, user: user) { data, response, error in
                if let error: Error = error {
                    let message = error.localizedDescription
                    self.showError = message                }
                if let response = response as? HTTPURLResponse {
                }
            }
        }
    
    
    
}
