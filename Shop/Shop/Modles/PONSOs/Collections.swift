//
//  Collections.swift
//  Shop
//
//  Created by Salma on 30/05/2022.
//

import Foundation
struct CustomCollection:Codable{
    var custom_collections:[CustomCollections]
}
struct CustomCollections:Codable{
var id:Int?
var title:String?
var image:[collectionImage]?
}
struct collectionImage:Codable{
    var width:Double?
    var height:Double?
    var src:String?
}
