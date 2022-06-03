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
            print("we are in all products")
            self.bindProducts()
        }
    }
    var categorys: [CustomCollection]?{
        didSet{
            print("we are in all categories")
            self.bindCategorys()
        }
    }
    var error: String?{
        didSet{
            print("we are in error")
            self.bindError()
        }
    }
     
    
    func fetchProducts (collectionID: Int = 395727569125){
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
    
    func filterPorductsByMainCategory(itemIndex: Int, completion: @escaping () -> Void ){
        if self.categorys == nil {
            print("No categories yet")
            fetchProducts()
        }else{
            if self.categorys!.count > 0{
                fetchProducts(collectionID: categorys![itemIndex].id!)
                self.bindProducts = completion
            }
        }
            }
}
 
