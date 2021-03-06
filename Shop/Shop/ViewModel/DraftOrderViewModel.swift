//
//  DraftOrderViewModel.swift
//  Shop
//
//  Created by Ali on 17/06/2022.
//

import Foundation

protocol PQ {
    func showMyAlert()
    func showDeleteAlert()
}


class DraftOrderViewModel {
    var pqq: PQ?
    let networkService: NetworkService!
    var bindDraftOrderLineItemsViewModelToView: (() -> ()) = {}
    var bindDraftViewModelErrorToView: (() -> ()) = {}
    var bindProductToView: (() -> ()) = {}
    var bindDraftViewModelMassageToView: (() -> ()) = {}
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    
    var bindMaxQuantToView: (() -> ()) = {}
    var bindNumberOfItemsToView: (() -> ()) = {}
    
    var maxQuant: Int? {
        didSet {
            self.bindMaxQuantToView()
        }
    }
    
    var numberOfItems: Int? {
        didSet {
            self.bindNumberOfItemsToView()
        }
    }
    
    var lineItems: [LineItem]? {
        didSet {
            self.bindDraftOrderLineItemsViewModelToView()
        }
    }
    
    var product: Product? {
        didSet {
            self.bindProductToView()
        }
    }
    
    var showError: String? {
        didSet {
            self.bindDraftViewModelErrorToView()
        }
    }
    
    var showMassage: String? {
        didSet {
            self.bindDraftViewModelMassageToView()
        }
    }
    
    init() {
       self.networkService = NetworkService()
   }
    
    func setProductDetailsVc(product: ProductDetailsVc) {
        pqq = product
    }
    
    func setCategory(cat: CategoryVc) {
        pqq = cat
    }
    
    func postNewDraftOrderWith(order: Api, flag: Bool = true, note: String = "0", lastName: String = "0", index: Int = 0) {
        let customerViewModel = CustomerViewModel()
        
        networkService.postNewDraftOrder(order: order) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let i = jsonObj!["draft_order"] as? [String: Any]
                let draftId = i!["id"] as! Int
                if flag == true {
                    DispatchQueue.main.async {
                        self.pqq?.showMyAlert()
                    }
                    customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: String(draftId), last_name: lastName)))
                }
                
                if flag == false {
                    DispatchQueue.main.async {
                        self.pqq?.showMyAlert()
                      //  self.pqq.addFillHeart()
                    }
                    print("hete")
                    customerViewModel.modifyCustomerFav(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: note, last_name: String(draftId))))
                    
                }
                
            } catch {
                print("\(error.localizedDescription)    postNewDraftOrderWith  vm")
                self.showError = error.localizedDescription
            }
        }
    }

    func getDraftOrderLineItems(id: String) {
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
    
    func getProductFromAPI(id: String) {
        networkService.getProductById(id: id) { prod, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.product = prod
            }
        }
    }
    
    func getMaxForAllProducts(products: [Int]) {
        
    }
    
    func deleteAnExistingDraftOrder(id: String, flag: Bool = true, note: String = "0", lastName: String = "0") {
        networkService.removeAnExistingDraftOrder(id: id) { data, response, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                if flag == true {
                    self.customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: "0", last_name: lastName)))
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
                let oldLineItems = arrOfLineItems!
                var new: [OrderItem] = []
                for item in oldLineItems {
                    if item.variant_id == variantId {
                        self.showError = "this product added before, choose a nother one"
                        return
                    }
                    let orderItem = OrderItem(variant_id: item.variant_id, quantity: item.quantity)
                    new.append(orderItem)
                }
                
                new.append(OrderItem(variant_id: variantId, quantity: 1))
                let api = Updated(draft_order: Modify(id: Int(id)!, line_items: new))
                self.networkService.ModifyAnExistingDraftOrder(id: id, order: api ) { data, response, error in
                    if let error: Error = error {
                        let message = error.localizedDescription
                        self.showError = message
                    }
                    
                    if data != nil {
                        //self.showMassage = "The Product is added to cart"
                        DispatchQueue.main.async {
                            self.pqq?.showMyAlert()
                        }
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        
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
            }
            
            if let response = response as? HTTPURLResponse  {}
        }
    }
    
    func getSingleProductVariant(variantid: String) {
        networkService.receiveSingleProductVariant(variantid: variantid) { variant, error in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
             //   self.maxQuant = variant?.inventory_quantity
            }
        }
    }
    
    func getNumberOfItemesInCart(id: String) {
        networkService.getSingleDraftOrder(id: id) { (items, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.numberOfItems = items?.count
            }
        }
    }
    
    func updateFavorite(id: String, variantId: Int, note: String) {
        networkService.getSingleDraftOrder(id: id) { (arrOfLineItems, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                let oldLineItems = arrOfLineItems!
                var new: [OrderItem] = []
                var flag: Bool = false
                for item in oldLineItems {
                    if item.variant_id == variantId {
                       // self.showError = "this product added before, choose a nother one"
                       // return
                        flag = true
                        continue
                    }
                    let orderItem = OrderItem(variant_id: item.variant_id, quantity: item.quantity)
                   
                    new.append(orderItem)
                }
                if !flag {
                    new.append(OrderItem(variant_id: variantId, quantity: 1))
                }
                if new.isEmpty {
                    self.networkService.removeAnExistingDraftOrder(id: id) { data, response, error in
                        if let error: Error = error {
                            let message = error.localizedDescription
                            self.showError = message
                        } else {
                            self.customerViewModel.modifyCustomerNote(id: String(userDefault().getId()), user: User(customer: Person(id: userDefault().getId(), note: note, last_name: "0")))
                            DispatchQueue.main.async {
                                self.pqq?.showDeleteAlert()
                            }
                        }
                    }
                } else {
                    let api = Updated(draft_order: Modify(id: Int(id)!, line_items: new))
                    self.networkService.ModifyAnExistingDraftOrder(id: id, order: api ) { data, response, error in
                        if let error: Error = error {
                            let message = error.localizedDescription
                            self.showError = message
                        }
                        
                        if data != nil {
                            //self.showMassage = "The Product is added to cart"
                            DispatchQueue.main.async {
                                if flag {
                                    self.pqq?.showDeleteAlert()
                                } else {
                                    self.pqq?.showMyAlert()
                                }
                            }
                        }
                        
                        if let response = response as? HTTPURLResponse {
                            
                        }
                    }
                }
            }
        }
    }
    
    func isProductFavorite(id: String, variantId: Int) {
        networkService.getSingleDraftOrder(id: id) { (arrOfLineItems, error) in
            if let error: Error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                let oldLineItems = arrOfLineItems!
                for item in oldLineItems {
                    if item.variant_id == variantId {
                       
                    }
                }
            }
    }
    
}
}
