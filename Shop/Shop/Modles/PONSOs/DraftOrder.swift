//
//  Order.swift
//  Shop
//
//  Created by Ali on 14/06/2022.


import Foundation


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
    let line_items: [Order]
    let customer: customer
}

struct Order: Codable {
    let variant_id: Int
    let quantity: Int
}


struct OrderItem: Codable {
    let variant_id: Int
    let quantity: Int
}

struct Orders: Codable{
    let orders: [OrderItem]
}
