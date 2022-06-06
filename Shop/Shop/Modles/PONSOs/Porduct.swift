//
//  Porduct.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import Foundation
struct AllProducts:Codable{
    let products:[Product]
}
// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, body_html, vendor,product_type: String
    let images:[productImage]
    let opitions:[productOpitions]?
    let variants:[Variant]?
}
struct productImage:Codable{
    let id:Int
    let product_id:Int
    let src:String
}
struct productOpitions:Codable{
 let id:Int
let product_id:Int
    let values:[String]?
}
struct Variant:Codable{
    let id:Int
    let product_id:Int
    let price:String
}
