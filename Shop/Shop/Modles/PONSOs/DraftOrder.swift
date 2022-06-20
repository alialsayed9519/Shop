//
//  Order.swift
//  Shop
//
//  Created by Ali on 14/06/2022.


import Foundation

struct Images: Codable {
    let images: [ProductImage]
}

struct ProductImage: Codable {
    let src: String
}




struct Draft: Decodable {
    let draft_order: DraftOrder
}

struct DraftOrder: Decodable {
    let id: Int
    let line_items: [LineItems]
}

struct LineItems: Decodable {
    let id: Int
    let variant_id: Int
    let product_id: Int
    let title: String
    let vendor: String
    let quantity: Int
    let price: String
}

struct customer: Codable {
    let id :Int
}






struct Api: Codable {
    let draft_order: Sendd
}

struct Sendd: Codable {
    let line_items: [OrderItem]
    let customer: customer
}

struct OrderItem: Codable {
    let variant_id: Int
    let quantity: Int
}

struct Orders: Codable{
    let orders: [OrderItem]
}



struct Updated: Codable {
    let draft_order: Modify
}

struct Modify: Codable {
    let id: Int
    let line_items: [OrderItem]
}
