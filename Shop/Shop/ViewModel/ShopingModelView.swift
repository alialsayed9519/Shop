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
        didSet{
            print("we are in all products computed property ")
            self.bindProducts()
        }
    }
    var categorys: [CustomCollection]?{
        didSet{
            print("we are in categories computed property")
            self.bindCategorys()
        }
    }
    var error: String?{
        didSet{
            print("we are in error computed property")
            self.bindError()
        }
    }
     
    func fetchOneProduct(productId:Int){
        network.fetchOneProduct(productID: "\(productId)"){(products,error)
            in
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
    func fetchProducts (collectionID: Int){
        network.fetchProducts(collectionID: "\(collectionID)") { (products, error) in
            if let message = error?.localizedDescription{
                self.error = message
            }else {
                if let respons = products {
                    self.allProduct = respons
                }
            }
        }
    }
    
    
    func fetchCustomCollection(){
        print("start of fetch categories")
        network.fetchCustomCatagegories { (customCollections, error) in
            if let error: Error = error{
                let message = error.localizedDescription
                self.error = message
                print(message)
            } else {
                if let respons = customCollections {
                    self.categorys = respons
                    print(respons)
                }
            }
            
        }
    }
    
    func filterPorductsByMainCategory(itemIndex: Int){
        guard let categories = self.categorys else {
            return
        }
        fetchProducts(collectionID: categories[itemIndex].id!)
    }
    
    func filterPorductsBySubCategory(subCategoryName: String) {
        self.allProduct = allProduct?.filter{
            ($0.product_type == subCategoryName)
        }
    }
    
    
}
 
