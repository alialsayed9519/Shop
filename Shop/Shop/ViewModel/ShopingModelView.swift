//
//  ShopingModelView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/30/22.
//

import Foundation

class ShopingViewModel{
    
    var bindProducts = {}
    var bindCategorys = {}
    var bindError = {}

    private var network = NetworkService()
    
    var allProduct: [Product]?{
        didSet{ self.bindProducts() }
    }
    var categorys: [CustomCollection]?{
        didSet{ self.bindCategorys() }
    }
    var error: String?{
        didSet{ self.bindError() }
    }
     
    
    func fetchProducts (collectionID: String){
        network.fetchProducts(collectionID: collectionID) { (products, error) in
            if let message = error?.localizedDescription{
                self.error = message
            }else {
                if let respons = products {
                    self.allProduct = respons
                }
            }
        }
    }
    
    
    func fetchCustonCollection(){
        network.fetchCustomCatagegories { (customCollections, error) in
            if let error: Error = error{
                let message = error.localizedDescription
                self.error = message
            } else {
                if let respons = customCollections {
                    self.categorys = respons
                }
            }
            
        }
    }
    
    func filterPorductsByMainCategory(itemIndex: Int, completion: @escaping () -> Void ){
        guard let itemsArray = self.categorys else {
            print("No categories yet")
            return
        }
        if itemsArray.count > 0{
            fetchProducts(collectionID: "\(String(describing: categorys![itemIndex].id!))")
            self.bindProducts = completion
        }
    }
}
