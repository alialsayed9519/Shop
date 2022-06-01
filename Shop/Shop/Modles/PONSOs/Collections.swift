//
//  Collections.swift
//  Shop
//
//  Created by Salma on 30/05/2022.
//

import Foundation
struct CustomCollections: Codable{
    var custom_collections: [CustomCollection]?
}

struct CustomCollection: Codable{
    var id: Int?
    var handle: String?
    var title:String?
    var updated_at: String?
    var body_html: String?
    var published_at: String?
    var sort_order: String?
    var template_suffix: String?
    var published_scope: String?
    var admin_graphql_api_id: String?
    var image: collectionImage?
    
    
    
}

struct collectionImage: Codable{
    var created_at: String?
    var alt: String?
    var width:Double?
    var height:Double?
    var src:String?
}
