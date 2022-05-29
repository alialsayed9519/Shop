//
//  Porduct.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import Foundation

struct AllProducts: Codable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
    }
}

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let vendor: String?
    let productType: String?
    let varients: [Varient]?
    let options: [OptionList]?
    let images: [ProductImage]
    var count: Int = 0
    
    enum CodingKeys : String , CodingKey {
        case id = "id"
        case title = "title"
        case description = "body_html"
        case vendor = "vendor"
        case productType = "product_type"
        case varients = "variants"
        case options = "options"
        case images = "images"
    }
}

struct Varient:Codable {
    let id:Int
    let productID:Int
    let title:String
    let price :String
    
    enum CodingKeys : String , CodingKey {
        case id = "id"
        case productID = "product_id"
        case title = "title"
        case price = "price"
    }
}

struct OptionList:Codable{
    let id:Int
    let productID :Int
    let name:String
    let position:Int
    let values:[String]?
    
    enum CodingKeys : String , CodingKey {
        case id = "id"
        case productID = "product_id"
        case name = "name"
        case position = "position"
        case values = "values"
    }
}

struct ProductImage:Codable {
    let id:Int
    let productID:Int
    let position:Int
    let width:Double
    let height:Double
    let src:String
    let graphQlID:String
    
   enum CodingKeys : String , CodingKey {
       case id = "id"
       case productID = "product_id"
       case position = "position"
       case width = "width"
       case height = "height"
       case src = "src"
       case graphQlID = "admin_graphql_api_id"
   }
}




