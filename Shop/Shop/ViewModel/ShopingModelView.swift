//
//  ShopingModelView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/30/22.
//

import Foundation

class ShopingViewModel{
    
    var bindProducts: (()->()) = {}
    var bindCategorys: (()->()) = {}
    var bindError: (()->()) = {}

//    private var network: NetworkService()
    
    var allProduct: [Product]{
        didSet{ self.bindProducts() }
    }
    var categorys: [CustomCollection]{
        didSet{ self.bindCategorys() }
    }
    var error: String?{
        didSet{ self.bindError() }
    }
    
    func fetchProdects(collectionID: String){
        network.fetch{ (products, Error) in
            if let error: Error = error {
                let message = error.lacalizedDescription
                self.bindError = message
            } else {
                if let respons = products {
                    self.allProduct = respons
                }
            }
        }
    }
    
    func fetchCustomCollections(){
        network.fetchCustomCollections{ (customCollection, Error) in
            if let error: Error = error {
                let message = error.lacalizedDescription
                self.bindError = message
            } else {
                if let respons = customCollection {
                    self.categorys = respons
                }
            }
        }
    }
    
    func filterPorductsByMainCategory(itemIndex: Int){
        if categorys.count > 0 {
            self.fetchProdects(collectionID: categorys[itemIndex].id)
        }
    }
}
