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
                print("\(String(describing: id))   postNewDraftOrderWith  vm")
                
                
                
            } catch {
                print(error.localizedDescription)
                self.showError = error.localizedDescription
            }
        }
    }
    
    func getDraftOrderLineItems(id: String = "1100811043074") {
        networkService.getSingleDraftOrder(id: id) { (orders, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.lineItems = orders
            }
        }
    }
    
    func getProductImageFromAPI(id: String = "42845057581314") {
        networkService.getProductImageById(id: id) { imageURL, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.imageURL = imageURL
            }
        }
    }
    
    func deleteAnExistingDraftOrder(id: String = "1100706447618") {
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
    
    func updateAnExistingDraftOrder(id: String = "1100811043074", variantId: Int) {
        networkService.getSingleDraftOrder(id: id) { (arrOfLineItems, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
       //         print(arrOfLineItems!)
                let oldLineItems = arrOfLineItems!
                var new: [OrderItem] = []
                for item in oldLineItems {
                    let orderItem = OrderItem(variant_id: item.variant_id, quantity: item.quantity)
                    new.append(orderItem)
                }
                
                new.append(OrderItem(variant_id: variantId, quantity: 1))
           //     print(new)
                let api = Updated(draft_order: Modify(id: Int(id)!, line_items: new))
           //     print(api)
                self.networkService.ModifyAnExistingDraftOrder(id: id, order: api ) { data, response, error in
                    if let error: Error = error {
                        let message = error.localizedDescription
                        self.showError = message
                        print(message)
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        print("\(response.statusCode)   vm")
                    }
                    
                }
            }
        }
    }
    
    
}
