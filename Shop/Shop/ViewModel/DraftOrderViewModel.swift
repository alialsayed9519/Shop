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
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    
    var lineItems: [LineItem]? {
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
    
    func postNewDraftOrderWith(order: Api, flag: Bool = true, note: String = "0", lastName: String = "0") {
        let customerViewModel = CustomerViewModel()
        
        networkService.postNewDraftOrder(order: order) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                print("postNewDraftOrderWith    vm")
                self.showError = message
            }
            guard let data = data else {
                return
            }
            
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let i = jsonObj!["draft_order"] as? [String: Any]
                let draftId = i!["id"] as! Int
                print(type(of: draftId))
                print("\(String(describing: draftId))   postNewDraftOrderWith  vm")
               // userDefault().setDraftOrder(note: String(draftId))
                if flag == true {
                    customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: String(draftId), last_name: lastName)))
                }
                
                if flag == false {
                    customerViewModel.modifyCustomerFav(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: note, last_name: String(draftId))))
                }
                
            } catch {
                print("\(error.localizedDescription)    postNewDraftOrderWith  vm")
                self.showError = error.localizedDescription
            }
        }
    }

    func getDraftOrderLineItems(id: String) {
        print(id)
        networkService.getSingleDraftOrder(id: id) { (items, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                print("   getDraftOrderLineItems  error")
                print(message)
                self.showError = message
            } else {
                print("   getDraftOrderLineItems  vm")
                self.lineItems = items
            }
        }
    }
    
    func getProductImageFromAPI(id: String) {
        networkService.getProductImageById(id: id) { imageURL, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.imageURL = imageURL
            }
        }
    }
    
    func deleteAnExistingDraftOrder(id: String, flag: Bool = true, note: String = "0", lastName: String = "0") {
        networkService.removeAnExistingDraftOrder(id: id) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                print("deleteAnExistingDraftOrder       vm")
                //userDefault().setDraftOrder(note: "0")
                print(data!)
                if flag == true {
                    self.customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: "0", last_name: "")))
                }
                if flag == false {
                    self.customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: note, last_name: "0")))
                }
            }
        }
    }
    //  when add new item to cart
    func updateAnExistingDraftOrder(id: String, variantId: Int) {
        networkService.getSingleDraftOrder(id: id) { (arrOfLineItems, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
       //         print(arrOfLineItems!)
                let oldLineItems = arrOfLineItems!
                var new: [OrderItem] = []
                for item in oldLineItems {
                    if item.variant_id == variantId {
                        self.showMassage = "this item added before, choose a nother one"
                        return
                    }
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
                        print("\(response.statusCode)   updateAnExistingDraftOrder   vm")
                        
                    }
                }
            }
        }
    }

    
    func updateAnExistingDraftOrder(id: String, items: [OrderItem]) {
        let newLineItems = Updated(draft_order: Modify(id: Int(id)!, line_items: items))
        networkService.ModifyAnExistingDraftOrder(id: id, order:  newLineItems) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
                print(message)
            }
            
            if let response = response as? HTTPURLResponse  {
                print("\(response.statusCode)   updateAnExistingDraftOrder   array   vm")
                
            }
        }
    }
    
}
