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
    let title, body_html, vendor: String




}
