//
//  BrandsViewModel.swift
//  Shop
//
//  Created by Ali on 30/05/2022.
//

import Foundation

class BrandsViewModel {
    let networkService: NetworkService!
    var bindBrandsViewModelToView: (() -> ()) = {}
    var bindViewModelErrorToView: (() -> ()) = {}
    
    var smartCollection: [SmartCollection]? {
        didSet {
            self.bindBrandsViewModelToView()
        }
    }
    
    var showError: String? {
        didSet {
            self.bindViewModelErrorToView()
        }
    }
    
    init() {
       self.networkService = NetworkService()
       self.fetchBrandsFromAPI()
   }
    
    func fetchBrandsFromAPI(){
        networkService.getAllBrands() { (brands, error) in
            if let error: Error = error {
                print("2222")
                let message = error.localizedDescription
                self.showError = message
                print(message)
            } else {
                print("BrandsViewModel")
                self.smartCollection = brands
            }
        }
    }
    
    
}
