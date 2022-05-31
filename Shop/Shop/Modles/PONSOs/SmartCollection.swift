//
//  SmartCollection.swift
//  Shop
//
//  Created by Ali on 30/05/2022.
//

import Foundation

struct Brand: Codable {
    let smart_collections: [SmartCollection]?
}

struct SmartCollection: Codable {
    let id: Int?
    let handle: String?
    let title: String?
    let updated_at: String?
    let body_html: String?
    let published_at: String?
    let sort_order: String?
    let template_suffix: String?
    let disjunctive: Bool?
    let rules: [Rule]?
    let published_scope: String?
    let admin_graphql_api_id: String?
    let image: Image?
}

struct Image: Codable {
    let created_at: String?
    let alt: String?
    let width: Int?
    let height: Int?
    let src: String?
}

struct Rule: Codable {
    let column: String?
    let relation: String?
    let condition: String?
}
