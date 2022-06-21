 //
//  ShopingModelView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/30/22.
//

import Foundation

class ShopingViewModel{
    var bindBrands={}
    var bindProducts = {}
    var bindCategorys = {}
    var bindError = {}
    var bindPriceRules = {}

    private var network = NetworkService()
    var brands:[Brand]?{
        didSet{
            self.bindBrands()
        }
    }
    var allProduct: [Product]?{
        didSet{
            self.bindProducts()
        }
    }
    var categorys: [CustomCollection]?{
        didSet{
            self.bindCategorys()
        }
    }
    var price_rules: [Price_Rule]?{
        didSet{
            self.bindPriceRules()
        }
    }
    var error: String?{
        didSet{
            self.bindError()
        }
    }
     
    
    func fetchProducts(collectionID: Int) {
        network.fetchProducts(collectionID: collectionID) { (products, error) in
            if let message = error?.localizedDescription{
                self.error = message
               // print(error?.localizedDescription)
            }else {
                if let respons = products {
                   // print(respons[0])
                    self.allProduct = respons
                }
            }
        }
    }
    
    
    func fetchCustomCollection(){
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
    
    func fetchAllProducts(){
        network.fetchAllProducts(){(products,error) in
            if let message=error?.localizedDescription{
                self.error = message
            }
            else {
                if let response=products{
                    self.allProduct=response
                }
            }
        }
    }
    
    func filterBrandsByNmae(brandName:String){
        fetchAllProducts()
        self.allProduct=allProduct?.filter{
            ($0.vendor==brandName)
        }
    }
    
    func filterPorductsByMainCategory(itemIndex: Int){
        guard let categories = self.categorys else {
            return
        }
        if(itemIndex==0){
            fetchAllProducts()
        }else{
            fetchProducts(collectionID: categories[itemIndex].id!)}
    }
    
    func filterPorductsBySubCategory(itemIndex: Int, subCategoryName: String) {
        guard let categories = self.categorys else {
            return
        }
        network.getProductBySubCategory(collectionId: categories[itemIndex].id!, productType: subCategoryName) { (products, error) in
            if let message = error?.localizedDescription{
                self.error = message
               // print(error?.localizedDescription)
            }else {
                if let respons = products {
                    self.allProduct = respons
                }
            }
        }
    }
    
    func fetchPriceRules(){
        network.fetchPriceRules(){(priceRule, error) in
            if let message = error?.localizedDescription{
                self.error = message
            }
            else {
                if let response = priceRule{
                    self.price_rules = response
                    userDefault().setFiftyDescountID(id: response[0].id)
                    userDefault().setFiftyDescountTitle(title: response[0].title)
                    userDefault().setThirtyDescountID(id: response[1].id)
                    userDefault().setThirtyDescountTitle(title: response[1].title)
                    userDefault().setDescountMessage(message: "For 50% off enter \(response[0].title)\nFor 30% off enter \(response[1].title)")
                }
            }
        }
    }
}
 
