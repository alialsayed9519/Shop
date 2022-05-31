//
//  Collections.swift
//  Shop
//
//  Created by Salma on 30/05/2022.
//

import Foundation
struct CustomCollections:Codable{
    var custom_collections:[CustomCollection]
}

struct CustomCollection:Codable{
var id:Int?
var title:String?
var image:[collectionImage]?
}

struct collectionImage:Codable{
    var width:Double?
    var height:Double?
    var src:String?
}
