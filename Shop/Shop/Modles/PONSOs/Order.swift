//
//  Order.swift
//  Shop
//
//  Created by yasmeen hosny on 6/19/22.
//

import Foundation

struct Order: Codable{
    var line_items: [LineItem]?
    var email: String?
    var pilling_address: Address?
    var financial_status: String = "paid"
    var currency:String?
    var current_total_price:String?
    var gateway: String?
    var total_discounts: String?
}

struct APIOrder: Codable {
    var order: Order
}

struct APIOrders: Codable {
    var orders: [Order]
}

struct OrderFromAPI: Codable {
    let customer: customer?
    let financial_status: String?
    let currency:String?
    let current_total_price:String?
    let gateway: String?
    let total_discounts: String?
    let created_at: String?
}

struct OrdersFromAPI: Codable {
    let orders: [OrderFromAPI]
}
