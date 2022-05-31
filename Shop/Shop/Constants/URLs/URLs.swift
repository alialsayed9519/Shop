//
//  URLs.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import Foundation

struct URLs {
    private static var baseURL = "https://mobile-ismailia.myshopify.com/admin/api/2022-04/"
    
    static func getCategoriesURL() -> String {
        return baseURL + "smart_collections.json"
    }
    static func allProducts()->String{
        return baseURL+"products.json"
    }
    static func customCollections()->String{
        return baseURL+"custom_collections.json"
    }
    static func products(collectionId:String)->String{
        return baseURL+"products.json?collection_id=\(collectionId)"
    }
}
