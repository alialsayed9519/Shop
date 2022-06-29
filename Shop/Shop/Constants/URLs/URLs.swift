//
//  URLs.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import Foundation

struct URLs {
    private static var baseURL = "https://54e7ce1d28a9d3b395830ea17be70ae1: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@mad-ism2022.myshopify.com/admin/api/2022-04/"
    
    static func getCategoriesURL() -> String {
        return baseURL + "smart_collections.json"
    }
    static func customer()->String{
        return baseURL+"customers.json"
    }
    static func allProducts()->String{
        return baseURL+"products.json"
    }
    static func customCollections()->String{
        return baseURL+"custom_collections.json"
    }
    static func products(collectionId:Int)->String{
        return baseURL+"products.json?collection_id=\(collectionId)"
    }
    
    static func brandproducts(collectionTitle:String)->String{
        return baseURL+"products.json?vendor=\(collectionTitle)"
    }

    static func customers() -> String {
        return baseURL + "customers.json"
    }
    
    static func customer(id: String) -> String {
        return baseURL + "customers/\(id).json"
    }
    
    static func oneAddress(customerId: Int, addressId: Int) -> String {
        return baseURL + "customers/\(customerId)/addresses/\(addressId).json"
    }
    
    static func allAddresses(customerId: Int) -> String {
        return baseURL + "customers/\(customerId)/addresses.json"
    }

    static func getDraftOrdersURL() -> String {
        return baseURL + "draft_orders.json"
    }
    
    static func getSingleDraftOrder(id: String) -> String {
        return baseURL + "draft_orders/\(id).json"
    }
    
    static func getProduct(id: String) -> String {
        return baseURL + "products/\(id).json"
    }
    
    static func deleteDraftOrder(id: String) -> String {
        return baseURL + "draft_orders/\(id).json"
    }
    
    static func modifyDeraftOrder(id: String) -> String {
        return baseURL + "draft_orders/\(id).json"
    }

    static func priceRole() -> String {
        return baseURL + "price_rules.json"
    }
    
    static func order()->String{
        return baseURL + "orders.json"
    }
    
    static func allOrders(customerId: Int)->String{
        return baseURL + "customers/\(customerId)/orders.json"
    }
    
    static func productsForSubCategory(collectionId: Int, productType: String) ->String{
        return products(collectionId: collectionId) + "&product_type=\(productType)"
    }
    static func receiveProductVariant(variantId: String) -> String {
        return baseURL + "variants/\(variantId).json"
    }
    
    static func allProductsForSubCategory(productType: String) ->String{
        return allProducts() + "&product_type=\(productType)"
    }
}


