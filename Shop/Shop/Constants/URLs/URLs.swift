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
}
