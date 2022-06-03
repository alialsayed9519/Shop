//
//  URLs.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import Foundation

struct URLs {
    private static var baseURL = "https://c48655414af1ada2cd256a6b5ee391be%20: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@mobile-ismailia.myshopify.com/admin/api/2022-04/"
    
    static func getCategoriesURL() -> String {
        let fullUrl = baseURL + "smart_collections.json"
        return fullUrl
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



