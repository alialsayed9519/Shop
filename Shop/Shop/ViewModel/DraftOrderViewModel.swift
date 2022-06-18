//
//  DraftOrderViewModel.swift
//  Shop
//
//  Created by Ali on 17/06/2022.
//

import Foundation

class DraftOrderViewModel {
    let networkService: NetworkService!
    var bindDraftOrderLineItemsViewModelToView: (() -> ()) = {}
    var bindDraftViewModelErrorToView: (() -> ()) = {}
    var bindImageURLToView: (() -> ()) = {}
    var bindDraftViewModelMassageToView: (() -> ()) = {}

    var lineItems: [LineItems]? {
        didSet {
            self.bindDraftOrderLineItemsViewModelToView()
        }
    }
    
    var imageURL: String? {
        didSet {
            self.bindImageURLToView()
        }
    }
    
    var showError: String? {
        didSet {
            self.bindDraftViewModelErrorToView()
        }
    }
    
    var showMassage: String? {
        didSet {
            self.bindDraftViewModelErrorToView()
        }
    }
    
    init() {
       self.networkService = NetworkService()
   }
    
    func postNewDraftOrderWith(order: Api) {
        networkService.postNewDraftOrder(order: order) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            }
            guard let data = data else {
                return
            }
            
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let i = jsonObj!["draft_order"] as? [String: Any]
                let id = i!["id"]
                print("\(String(describing: id))   jjkjjkjkkjjkjkjjjjjjkkjjk")
                
                
                
            } catch {
                print(error.localizedDescription)
                self.showError = error.localizedDescription
            }
        }
    }
    
    func getDraftOrderLineItems(id: String = "1100727484674") {
        networkService.getSingleDraftOrder(id: id) { (orders, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.lineItems = orders
            }
        }
    }
    
    func getProductImageFromAPI(id: String = "1098303865090") {
        networkService.getProductImageById(id: id) { imageURL, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.imageURL = imageURL
            }
        }
    }
    
    func deleteAnExistingDraftOrder(id: String = "1100412387586") {
        networkService.removeAnExistingDraftOrder(id: id) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                print("good")
                print(data!)
            }
        }
    }
    
    func updateAnExistingDraftOrder(id: String = "1100727484674", order: Api) {
        networkService.ModifyAnExistingDraftOrder(id: id, order: order) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            }
        }
    }
    
    
}
