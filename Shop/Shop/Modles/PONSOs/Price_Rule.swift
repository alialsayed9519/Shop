//
//  Price_Rule.swift
//  Shop
//
//  Created by yasmeen hosny on 6/17/22.
//

import Foundation

struct Price_Rules: Codable {
    let price_rules: [Price_Rule]
}

struct Price_Rule: Codable {
    let id: Int
    let title: String
}
