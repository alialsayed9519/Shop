//
//  Porduct.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import Foundation
struct AllProducts:Codable{
    var products:[Product]
}
struct Product:Codable{
    var id :Int?
    var title:String?
    var description:String?
    var product_type:String?
    var vendor:String?
    var options:[productOptions]?
    var images:[productImage]?
    var variants:[productvariants]?
    
    enum CodingKeys : String , CodingKey {
        case  description="body_html"
    }
}
struct productOptions:Codable{
    var id:Int?
    var product_id:Int?
    var name:String?
    var values:[String]?
}
struct productImage:Codable{
    var id:Int
    var product_id:Int?
    var position:Int?
    var width:Double?
    var height:Double?
    var src:String?
    var admin_graphql_api_id:String
}
struct productvariants:Codable{
    var id:Int?
    var product_id:Int?
    var title:String?
    var price:String?
    var postion:Int?
    
}
