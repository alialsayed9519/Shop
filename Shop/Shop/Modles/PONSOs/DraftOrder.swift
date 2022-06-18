//
//  DraftOrder.swift
//  Shop
//
//  Created by yasmeen hosny on 6/18/22.
//

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
    let quantity: Int
    let price: String
}

struct customer: Codable {
    let id :Int
    let email: String
    let first_name: String
    let last_name: String
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
