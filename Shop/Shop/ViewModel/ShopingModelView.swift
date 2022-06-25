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
    var error: String?{
        didSet{
            self.bindError()
        }
    }
     
    
    func fetchProducts(collectionID: Int = 395727569125) {
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
    
    func fetchbrandProducts(collectionTitle: String = "ADIDAS") {
        network.fetchbrandProducts(collectionTitle: collectionTitle) { (products, error) in
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
                self.error=message
                
            }
            else {
                if let response=products{
                    self.allProduct=response
                }
            }
                
        }
    }
    func filterBrandsByNmae(brandName:String){
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
    
    func filterPorductsBySubCategory(subCategoryName: String) {
        self.allProduct = allProduct?.filter{
            ($0.product_type == subCategoryName)
        }
    }
}
 
