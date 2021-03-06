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
   var bindSubCategories = {}
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
   
   var allProductForSubCategory: [Product]?{
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
           }else {
               if let respons = products {
                   self.allProduct = respons
               }
           }
       }
   }
   
   func fetchbrandProducts(collectionTitle: String = "ADIDAS") {
       network.fetchbrandProducts(collectionTitle: collectionTitle) { (products, error) in
           if let message = error?.localizedDescription{
               self.error = message           }else {
               if let respons = products {
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
           print("return")
           return
       }
       network.getProductBySubCategory(generalFlag: false, collectionId: categories[itemIndex].id!, productType: subCategoryName) { (products, error) in
           
           guard let error = error else {
               print("error is: \(error)")
               return
           }
           guard let products = products else {
               print("no products")
               return
           }
           self.allProductForSubCategory = products
           
       }
   }
   
   func fetchPriceRules(){
       network.fetchPriceRules(){(priceRule, error) in
           if let message = error?.localizedDescription{
               self.error = message
           }
           else {
               if let response = priceRule{
                   userDefault().setFiftyDescountID(id: response[0].id)
                   userDefault().setFiftyDescountTitle(title: response[0].title)
                   userDefault().setThirtyDescountID(id: response[1].id)
                   userDefault().setThirtyDescountTitle(title: response[1].title)
                   self.price_rules = response

               }
           }
       }
   }
}

