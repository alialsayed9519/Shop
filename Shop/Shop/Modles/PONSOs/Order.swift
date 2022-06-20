//
//  Order.swift
//  Shop
//
//  Created by yasmeen hosny on 6/19/22.
//

import Foundation

struct Order: Codable{
    var line_items: [LineItems]?
    var email: String?
    var pilling_address: Address?
    var financial_status: String = "paid"
    var currency:String?
    var current_total_price:String?
    var gateway: String?
    var discount: String?
}

struct APIOrder: Codable {
    var order: Order
}

struct APIOrders: Codable {
    var orders: [Order]
}
